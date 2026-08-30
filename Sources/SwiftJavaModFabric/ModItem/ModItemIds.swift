import MinecraftJavaAPI
import SwiftJava

public enum ModItemIds {
    public static var suspiciousSubstance: ResourceKey<Item> {
        create("suspicious_substance")
    }

    public static var swiftBridgeItem: ResourceKey<Item> {
        create("swift_bridge_item")
    }

    public static var walkingSpeedItem: ResourceKey<Item> {
        create("walking_speed_item")
    }

    public static var blockBreakerItem: ResourceKey<Item> {
        create("block_breaker_item")
    }

    public static var iosdcBadgeItem: ResourceKey<Item> {
        create("iosdc_badge_item")
    }

    static var pureSwiftItem: ResourceKey<Item> {
        create("pure_swift_item")
    }

    private static func create(_ name: String) -> ResourceKey<Item> {
        let identifierClass = try! JavaClass<Identifier>()
        let registriesClass = try! JavaClass<Registries>()
        let resourceKeyClass = try! JavaClass<ResourceKey<Item>>()

        let identifier = identifierClass.fromNamespaceAndPath(modID, name)

        return resourceKeyClass.create(
            registriesClass.ITEM,
            identifier
        )
    }
}