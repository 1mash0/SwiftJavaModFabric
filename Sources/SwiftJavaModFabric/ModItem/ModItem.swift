import MinecraftJavaAPI
import SwiftJava

enum ModItem: String, CaseIterable {
    case swiftBridgeItem = "swift_bridge_item"
    case walkingSpeedItem = "walking_speed_item"
    case blockBreakerItem = "block_breaker_item"
    case iosdcBadgeItem = "iosdc_badge_item"
    case pureSwiftItem = "pure_swift_item"

    static func initialize() {
        let builtInRegistriesClass = try! JavaClass<MinecraftBuiltInRegistries>()
        let registryClass = try! JavaClass<Registry<Item>>()

        guard let defaultedRegistry = builtInRegistriesClass.ITEM else {
            return
        }

        let itemRegistry = defaultedRegistry.as(Registry<Item>.self)

        let allItems = ModItem.allCases.map {
            let key = $0.makeKey()
            return (key: key, item: $0.makeItem(key: key))
        }

        for (key, item) in allItems {
            _ = registryClass.register(
                itemRegistry,
                key,
                item
            )
        }

        // CreativeModeTabEvents の callback 登録だけ Java helper に委譲している。
        let creativeTabRegistrationClass = 
            try! JavaClass<JavaCreativeTabRegistration>()
        _ = creativeTabRegistrationClass.addToIngredientsTab(allItems.map { $0.item })
    }

    private func makeKey() -> ResourceKey<Item> {
        let identifierClass = try! JavaClass<Identifier>()
        let registriesClass = try! JavaClass<Registries>()
        let resourceKeyClass = try! JavaClass<ResourceKey<Item>>()

        let identifier = identifierClass.fromNamespaceAndPath(modID, self.rawValue)

        return resourceKeyClass.create(
            registriesClass.ITEM,
            identifier
        )
    }

    private func makeItem(key: ResourceKey<Item>) -> Item {
        let properties = ItemProperties().setId(key)

        switch self {
        case .swiftBridgeItem:
            return SwiftBridgeItem(properties)
        case .walkingSpeedItem:
            return WalkingSpeedItem(properties)
        case .blockBreakerItem:
            return BlockBreakerItem(properties)
        case .iosdcBadgeItem:
            return IOSDCBadgeItem(properties)
        case .pureSwiftItem:
            return SwiftItem(properties)
        }
    }
}
