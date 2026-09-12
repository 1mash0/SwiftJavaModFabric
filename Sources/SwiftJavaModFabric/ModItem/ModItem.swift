import MinecraftJavaAPI
import SwiftJava

enum ModItem: String, CaseIterable {
    case swiftBridgeItem = "swift_bridge_item"
    case walkingSpeedItem = "walking_speed_item"
    case iosdcBadgeItem = "iosdc_badge_item"
    case pureSwiftItem = "pure_swift_item"

    var itemType: (any SwiftItemProtocol.Type)? {
        switch self {
            case .swiftBridgeItem:
                return SwiftBridgeItem.self
            case .walkingSpeedItem:
                return WalkingSpeedItem.self
            case .iosdcBadgeItem:
                return IOSDCBadgeItem.self
            case .pureSwiftItem:
                return SwiftItem.self
        }
    }

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
        case .iosdcBadgeItem:
            return IOSDCBadgeItem(properties)
        case .pureSwiftItem:
            return SwiftItem(properties)
        }
    }
}

extension ModItem {
    var registeredItem: Item? {
        let identifierClass = try! JavaClass<Identifier>()
        let builInRegistriesClass = try! JavaClass<MinecraftBuiltInRegistries>()

        let identifier = identifierClass.fromNamespaceAndPath(
            modID,
            self.rawValue
        )

        guard
            let defaultedRegistry = builInRegistriesClass.ITEM,
            let itemRegistry = defaultedRegistry.as(Registry<Item>.self)
        else {
            return nil
        }

        return itemRegistry.getValue(identifier)
    }

    static func find(for item: Item) -> ModItem? {
        allCases.first { modItem in
            guard let registeredItem = modItem.registeredItem else {
                return false
            }
            return item.equals(registeredItem)
        }
    }
}
