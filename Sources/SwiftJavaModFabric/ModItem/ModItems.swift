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

        return Item(configuredProperties)
    }()

    public static func initialize() {
        let modItemsClass = try! JavaClass<JavaModItems>()

        _ = modItemsClass.register(ModItemIds.PURE_SWIFT_ITEM, PURE_SWIFT_ITEM)
    }

    public static func registerCreativeTab() {
        let modItemsClass = try! JavaClass<JavaModItems>()

        _ = modItemsClass.addToIngredientsTab([PURE_SWIFT_ITEM])
    }
}