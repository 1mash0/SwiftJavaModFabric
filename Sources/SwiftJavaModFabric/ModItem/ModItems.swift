import MinecraftJavaAPI
import SwiftJava

public enum ModItems {
    // nonisolated(unsafe) でなくても良い
    // その場合は `initialize()` 内で Item を生成する必要がある
    nonisolated(unsafe) static let pureSwiftItem: Item = {
        let properties = ItemProperties()
        let configuredProperties = properties.setId(
            ModItemIds.pureSwiftItem
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
            ModItemIds.pureSwiftItem,
            pureSwiftItem
        )
    }

    
    public static func registerCreativeTab() {
        // CreativeModeTabEvents の callback 登録だけ Java helper に委譲している。
        let modItemsClass = try! JavaClass<JavaModItems>()

        _ = modItemsClass.addToIngredientsTab([pureSwiftItem])
    }
}