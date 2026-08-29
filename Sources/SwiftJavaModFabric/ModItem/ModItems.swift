import MinecraftJavaAPI
import SwiftJava

public enum ModItems {
    // nonisolated(unsafe) でなくても良い
    // その場合は `initialize()` 内で Item を生成する必要がある
    nonisolated(unsafe) static let PURE_SWIFT_ITEM: Item = {
        let properties = ItemProperties()
        let configuredProperties = properties.setId(
            ModItemIds.PURE_SWIFT_ITEM
        )
        return SwiftItem(configuredProperties)
    }()

    public static func initialize() {
        let builtInRegistriesClass = try! JavaClass<MinecraftBuiltInRegistries>()
        let registryClass = try! JavaClass<Registry<Item>>()

        guard let defaultedRegistry = builtInRegistriesClass.ITEM else {
            return
        }

        let itemRegistry = defaultedRegistry.as(Registry<Item>.self)

        _ = registryClass.register(
            itemRegistry,
            ModItemIds.PURE_SWIFT_ITEM,
            PURE_SWIFT_ITEM
        )
    }

    
    public static func registerCreativeTab() {
        // CreativeModeTabEvents の callback 登録だけ Java helper に委譲している。
        let modItemsClass = try! JavaClass<JavaModItems>()

        _ = modItemsClass.addToIngredientsTab([PURE_SWIFT_ITEM])
    }
}