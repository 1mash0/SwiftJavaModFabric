import MinecraftJavaAPI
import SwiftJava

protocol SwiftItemProtocol {
    static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32
}

final class SwiftBridgeItem: Item, SwiftItemProtocol {
    static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32 {
        let level = Level(javaThis: levelObject.javaThis, environment: levelObject.javaEnvironment)

        // `literal` を使うと依存パッケージが増えるため、`nullToEmpty` を使う。
        if !level.isClientSide() {
            let player = Player(javaThis: playerObject.javaThis, environment: playerObject.javaEnvironment)
            let message = try? JavaClass<Component>().nullToEmpty("テスト")
            player.sendOverlayMessage(message)
        }

        guard let serverPlayer = playerObject.as(ServerPlayer.self) else {
            return 2
        }

        ModItemService.showTitle(serverPlayer, title: SwiftBridge.hello(), subtitle: "Sub Title")

        return 0
    }
}

final class WalkingSpeedItem: Item, SwiftItemProtocol {
    static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32 {
        let normalWalkingSpeed = 0.1
        let boostedWalkingSpeed = 1.0

        guard
            let level = levelObject.as(Level.self),
            !level.isClientSide(),
            let player = playerObject.as(ServerPlayer.self),
            let attributesClass = try? JavaClass<Attributes>(),
            let movementSpeedAttribute = attributesClass.MOVEMENT_SPEED,
            let movementSpeed = player.getAttribute(movementSpeedAttribute)
        else {
            return 3 // FAIL
        }

        let currentBaseValue = movementSpeed.getBaseValue()

        let newBaseValue = if currentBaseValue < boostedWalkingSpeed {
            boostedWalkingSpeed
        } else {
            normalWalkingSpeed
        }

        movementSpeed.setBaseValue(newBaseValue)

        return 1 // SUCCESS
    }
}

final class IOSDCBadgeItem: Item, SwiftItemProtocol {
    static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32 {
        guard
            let level = levelObject.as(Level.self),
            !level.isClientSide(),
            let player = playerObject.as(ServerPlayer.self),
            let server = level.getServer(),
            let advancementManager = server.getAdvancements(),
            let identifierClass = try? JavaClass<Identifier>(),
            let advancementId = identifierClass.fromNamespaceAndPath(
                modID,
                "presented_iosdc_lt"
            ),
            let advancement = advancementManager.get(advancementId),
            let playerAdvancements = player.getAdvancements()
        else {
            return 0
        }

        let award = playerAdvancements.award(
            advancement,
            "presented_iosdc_lt"
        )

        if !award {
            return 3
        }

        ModItemService.showTitle(player, title: "ありがとうございました！")

        return 1
    }
}

final class SwiftItem: Item, SwiftItemProtocol {
    static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32 {
        // Implement the behavior for when the SwiftItem is used.
        return 0
    }
}