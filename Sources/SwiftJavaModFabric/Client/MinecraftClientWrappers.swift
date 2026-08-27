import SwiftJava

@JavaClass("net.minecraft.client.Minecraft")
open class MinecraftClient: JavaObject {
    @JavaField(isFinal: true)
    var font: MinecraftFont?

    @JavaField(isFinal: false)
    var hitResult: MinecraftHitResult?

    @JavaField(isFinal: false)
    var level: MinecraftClientLevel?
}

extension JavaClass<MinecraftClient> {
    @JavaStaticMethod
    func getInstance() -> MinecraftClient?
}

@JavaClass("net.minecraft.client.gui.Font")
open class MinecraftFont: JavaObject {
    @JavaMethod
    open func width(_ text: String) -> Int32
}

@JavaClass("net.minecraft.client.gui.GuiGraphicsExtractor")
open class MinecraftGuiGraphicsExtractor: JavaObject {
    @JavaMethod
    open func guiWidth() -> Int32

    @JavaMethod
    open func guiHeight() -> Int32

    @JavaMethod
    open func text(
        _ font: MinecraftFont?,
        _ text: String,
        _ x: Int32,
        _ y: Int32,
        _ color: Int32,
        _ dropShadow: Bool
    )
}

@JavaClass("net.minecraft.client.multiplayer.ClientLevel")
open class MinecraftClientLevel: JavaObject {
    @JavaMethod
    open func getBlockState(
        _ pos: MinecraftBlockPos?
    ) -> MinecraftBlockState?
}

@JavaClass("net.minecraft.world.phys.HitResult")
open class MinecraftHitResult: JavaObject {
    @JavaMethod
    open func getType() -> MinecraftHitResultType?
}

@JavaClass("net.minecraft.world.phys.HitResult$Type")
open class MinecraftHitResultType: JavaObject {}

extension JavaClass<MinecraftHitResultType> {
    @JavaStaticField(isFinal: true)
    var BLOCK: MinecraftHitResultType?
}

@JavaClass(
    "net.minecraft.world.phys.BlockHitResult",
    extends: MinecraftHitResult.self
)
open class MinecraftBlockHitResult: MinecraftHitResult {
    @JavaMethod
    open func getBlockPos() -> MinecraftBlockPos?
}

@JavaClass("net.minecraft.core.BlockPos")
open class MinecraftBlockPos: JavaObject {}

@JavaClass("net.minecraft.world.level.block.state.BlockState")
open class MinecraftBlockState: JavaObject {
    @JavaMethod
    open func getBlock() -> MinecraftBlock?
}

@JavaClass("net.minecraft.world.level.block.Block")
open class MinecraftBlock: JavaObject {
    @JavaMethod
    open func getName() -> MinecraftMutableComponent?
}

@JavaClass("net.minecraft.network.chat.MutableComponent")
open class MinecraftMutableComponent: JavaObject {
    @JavaMethod
    open func getString() -> String
}