import MinecraftJavaAPI
import SwiftJava

@JavaInterface("net.fabricmc.fabric.api.event.player.ItemEvents")
struct FabricItemEvents {}

@JavaInterface("net.fabricmc.fabric.api.event.player.ItemEvents$UseCallback")
struct FabricItemUseCallback {}

@JavaClass("net.fabricmc.fabric.api.event.Event")
open class FabricEvent<T: AnyJavaObject>: JavaObject {
    @JavaMethod
    open func register(_ listener: T?)
}

extension JavaClass<FabricItemEvents> {
    @JavaStaticField(isFinal: true)
    var USE: FabricEvent<FabricItemUseCallback>?
}

@JavaClass("net.minecraft.world.InteractionHand")
open class FabricInteractionHand: JavaObject {}

@JavaClass("net.minecraft.world.item.ItemStack")
open class FabricItemStack: JavaObject {
    @JavaMethod
    open func getItem() -> Item?
}

@JavaClass("net.minecraft.world.entity.player.Player")
open class FabricInteractionPlayer: JavaObject {
    @JavaMethod
    open func getItemInHand(
        _ hand: FabricInteractionHand?
    ) -> FabricItemStack?
}