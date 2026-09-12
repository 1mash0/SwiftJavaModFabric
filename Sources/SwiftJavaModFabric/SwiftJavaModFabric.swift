import MinecraftJavaAPI
import SwiftJava

public enum SwiftBridge {
    public static func hello() -> String {
        "Hello from Swift!"
    }
}

let modID = "swift-java-mod-fabric"

public func initializeMod() {
    ModItem.initialize()
    registerItemUseCallback()
    registerCreativeTabCallback()
}

private func registerItemUseCallback() {
    let callback = FabricCallback.make(
        "com.example.swift.ModItemBridge::onItemUse",
        as: FabricItemUseCallback.self
    )

    let itemEventsClass = try! JavaClass<FabricItemEvents>()

    guard let useEvent = itemEventsClass.USE else {
        fatalError("Failed to get ItemEvents.USE")
    }

    useEvent.register(callback)
}

private func registerCreativeTabCallback() {
    let callback = FabricCallback.make(
        "com.example.swift.ModItemBridge::modifyCreativeTab",
        as: FabricCreativeModeTabEventsModifyOutput.self
    )

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
    let element = FabricCallback.make(
        "com.example.swift.HudRenderer::renderHudElement",
        as: FabricHudElement.self
    )

    let registryClass = try! JavaClass<FabricHudElementRegistry>()
    registryClass.addLast(
        hudId,
        element
    )
}
