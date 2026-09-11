import MinecraftJavaAPI
import SwiftJava

public enum SwiftBridge {
    public static func hello() -> String {
        "Hello from Swift!"
    }
}

let modID = "swift-java-mod-fabric"

public func initializeMod() {
    ModLogger.info("Hello Fabric world from Swift!")

    ModItem.initialize()

    registerItemUseCallback()
    registerCreativeTabCallback()
}

private func registerItemUseCallback() {
    let fabricLoaderClass = try! JavaClass<FabricLoader>()

    guard
        let loader = fabricLoaderClass.getInstance(),
        let containerOptional = loader.getModContainer(modID),
        let container = containerOptional.orElseThrow()
    else {
        fatalError("Failed to get ModContainer")
    }

    let languageAdapterClass = try! JavaClass<FabricLanguageAdapter>()

    guard let adapter = languageAdapterClass.getDefault() else {
        fatalError("Failed to get LanguageAdapter")
    }

    let callbackClass = try! JavaClass<FabricItemUseCallback>()

    let callback: FabricItemUseCallback

    do {
        callback = try adapter.create(
            container,
            "com.example.swift.ModItemBridge::onItemUse",
            callbackClass
        )
    } catch {
        fatalError("Failed to create ItemEvents.UseCallback: \(error)")
    }

    let itemEventsClass = try! JavaClass<FabricItemEvents>()

    guard let useEvent = itemEventsClass.USE else {
        fatalError("Failed to get ItemEvents.USE")
    }

    useEvent.register(callback)
}

private func registerCreativeTabCallback() {
    let fabricLoaderClass = try! JavaClass<FabricLoader>()

    guard
        let loader = fabricLoaderClass.getInstance(),
        let containerOptional = loader.getModContainer(modID),
        let container = containerOptional.orElseThrow()
    else {
        fatalError("Failed to get ModContainer")
    }

    let languageAdapterClass = try! JavaClass<FabricLanguageAdapter>()

    guard let adapter = languageAdapterClass.getDefault() else {
        fatalError("Failed to get LanguageAdapter")
    }

    let callbackClass = try! JavaClass<FabricCreativeModeTabEventsModifyOutput>()

    let callback: FabricCreativeModeTabEventsModifyOutput

    do {
        callback = try adapter.create(
            container,
            "com.example.swift.ModItemBridge::modifyCreativeTab",
            callbackClass
        )
    } catch {
        fatalError("Failed to create CreativeModeTabEvents.ModifyOutput: \(error)")
    }

    let creativeModeTabsClass = try! JavaClass<MinecraftCreativeModeTabs>()

    let creativeModeTabEventsClass = try! JavaClass<FabricCreativeModeTabEvents>()

    guard
        let ingredients = creativeModeTabsClass.INGREDIENTS,
        let modifyOutputEvent = creativeModeTabEventsClass.modifyOutputEvent(ingredients)
    else {
        fatalError("Failed to get creative mode tab event")
    }

    modifyOutputEvent.register(callback)
}

public func initializeClientMod() {
    let identifierClass = try! JavaClass<Identifier>()
    let hudId = identifierClass.fromNamespaceAndPath(
        modID,
        "hud"
    )

    let fabricLoaderClass = try! JavaClass<FabricLoader>()
    guard
        let loader = fabricLoaderClass.getInstance(),
        let containerOptional = loader.getModContainer(modID),
        let container = containerOptional.orElseThrow()
    else {
        fatalError("Failed to get ModContainer")
    }

    let languageAdapterClass = try! JavaClass<FabricLanguageAdapter>()
    guard let languageAdapter = languageAdapterClass.getDefault() else {
        fatalError("Failed to get LanguageAdapter")
    }

    let hudElementClass = try! JavaClass<FabricHudElement>()

    let element: FabricHudElement
    do {
        element = try languageAdapter.create(
            container,
            "com.example.swift.HudRenderer::renderHudElement",
            hudElementClass
        )
    } catch {
        fatalError("Failed to create HudElement: \(error)")
    }

    let registryClass = try! JavaClass<FabricHudElementRegistry>()
    registryClass.addLast(
        hudId,
        element
    )
}