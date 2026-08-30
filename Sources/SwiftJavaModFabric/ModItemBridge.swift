import Foundation
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

        ModItemService.showTitle(serverPlayer, title: SwiftBridge.hello(), subtitle: "Sub Title")

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

    public static func onPlayerTick(_ playerObject: JavaObject) {
        let horizontalMargin = 0.05
        let verticalMargin = 0.1

        guard
            let player = playerObject.as(ServerPlayer.self),
            let boundingBox = player.getBoundingBox()
        else {
            return
        }

        // 左右・前後だけ少し広げる。
        // 足元の床を壊さないよう、Y方向は内側へ狭める。
        let minX = Int32(
            floor(boundingBox.minX - horizontalMargin)
        )
        let maxX = Int32(
            floor(boundingBox.maxX + horizontalMargin)
        )

        let minY = Int32(
            floor(boundingBox.minY + verticalMargin)
        )
        let maxY = Int32(
            floor(boundingBox.maxY - verticalMargin)
        )

        let minZ = Int32(
            floor(boundingBox.minZ - horizontalMargin)
        )
        let maxZ = Int32(
            floor(boundingBox.maxZ + horizontalMargin)
        )

        for x in minX...maxX {
            for y in minY...maxY {
                for z in minZ...maxZ {
                    let position = BlockPos(
                        x,
                        y,
                        z
                    )

                    _ = player.gameMode.destroyBlock(position)
                }
            }
        }
    }

    public static func finishPresentation(
        _ levelObject: JavaObject,
        _ playerObject: JavaObject
    ) -> Int32 {
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