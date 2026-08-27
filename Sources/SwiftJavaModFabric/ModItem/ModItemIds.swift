import MinecraftJavaAPI
import SwiftJava

enum ModItemIds {
    private static let modId = "swift-java-mod-fabric"

    static var PURE_SWIFT_ITEM: ResourceKey<Item> {
        create("pure_swift_item")
    }

    private static func create(_ name: String) -> ResourceKey<Item> {
        let identifierClass = try! JavaClass<Identifier>()
        let registriesClass = try! JavaClass<Registries>()
        let resourceKeyClass = try! JavaClass<ResourceKey<Item>>()

        let identifier = identifierClass.fromNamespaceAndPath(modId, name)

        return resourceKeyClass.create(
            registriesClass.ITEM,
            identifier
        )
    }
}