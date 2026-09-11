import Foundation
import MinecraftJavaAPI
import SwiftJava

public enum ModItemBridge {
    public static func onItemUse(
        _ levelObject: JavaObject,
        _ playerObject: JavaObject,
        _ handObject: JavaObject
    ) -> InteractionResult? {
        guard
            let player = playerObject.as(FabricInteractionPlayer.self),
            let hand = handObject.as(FabricInteractionHand.self),
            let itemStack = player.getItemInHand(hand),
            let heldItem = itemStack.getItem(),
            let modItem = ModItem.find(for: heldItem),
            let itemType = modItem.itemType
        else {
            return nil
        }

        let result = itemType.onUse(levelObject, playerObject)

        return interactionResult(for: result)
    }

    public static func modifyCreativeTab(
        _ outputObject: JavaObject
    ) {
        guard let output = outputObject.as(FabricCreativeModeTabOutput.self) else {
            return
        }

        for modItem in ModItem.allCases {
            guard
                let item = modItem.registeredItem,
                let itemLike = item.as(MinecraftItemLike.self)
            else {
                continue
            }
            output.accept(itemLike)
        }
    }

    private static func interactionResult(
        for result: Int32?
    ) -> InteractionResult? {
        let interactionResultClass =
            try! JavaClass<InteractionResult>()

        return switch result {
            case 0: interactionResultClass.PASS?.as(InteractionResult.self)
            case 1: interactionResultClass.SUCCESS?.as(InteractionResult.self)
            case 2: interactionResultClass.CONSUME?.as(InteractionResult.self)
            case 3: interactionResultClass.FAIL?.as(InteractionResult.self)
            default: nil
        }
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
}