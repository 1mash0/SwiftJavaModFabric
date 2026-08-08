import MinecraftJavaAPI
import SwiftJava

public enum ModItemBridge {
    public static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32 {
        let level = Level(javaThis: levelObject.javaThis, environment: levelObject.javaEnvironment)

        let message = try! JavaClass<Component>()

        // `literal` を使うと依存パッケージが増えるため、`nullToEmpty` を使う。
        if let message = try? JavaClass<Component>().nullToEmpty("テスト"), !level.isClientSide() {
            let player = Player(javaThis: playerObject.javaThis, environment: playerObject.javaEnvironment)
            player.sendOverlayMessage(message)
        }

        guard let serverPlayer = playerObject.as(ServerPlayer.self) else {
            return 2
        }

        ModItemService.showTitle(serverPlayer)

        return 0
    }

    public static func changeWalkingSpeed(
        _ levelObject: JavaObject,
        _ playerObject: JavaObject
    ) -> Int32 {
        let normalWalkingSpeed = 0.1
        let boostedWalkingSpeed = 2.0

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