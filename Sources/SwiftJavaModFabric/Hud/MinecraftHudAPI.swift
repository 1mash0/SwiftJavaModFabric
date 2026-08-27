import SwiftJava

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
    open func text(
        _ font: MinecraftFont?,
        _ text: String,
        _ x: Int32,
        _ y: Int32,
        _ color: Int32,
        _ dropShadow: Bool
    )
}

@JavaClass("net.minecraft.client.Minecraft")
open class MinecraftClient: JavaObject {
    @JavaField(isFinal: true)
    var font: MinecraftFont?
}

extension JavaClass<MinecraftClient> {
    @JavaStaticMethod
    func getInstance() -> MinecraftClient!
}