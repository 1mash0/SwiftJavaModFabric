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
        for result: SwiftItemUseResult
    ) -> InteractionResult? {
        let interactionResultClass =
            try! JavaClass<InteractionResult>()

        return switch result {
            case .pass: interactionResultClass.PASS?.as(InteractionResult.self)
            case .success: interactionResultClass.SUCCESS?.as(InteractionResult.self)
            case .consume: interactionResultClass.CONSUME?.as(InteractionResult.self)
            case .fail: interactionResultClass.FAIL?.as(InteractionResult.self)
            case .delegate: nil
        }
    }
}