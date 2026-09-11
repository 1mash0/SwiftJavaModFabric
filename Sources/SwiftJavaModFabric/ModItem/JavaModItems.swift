import MinecraftJavaAPI
import SwiftJava

// CreativeModeTabEvents の callback 登録を行う Java helper の wrapper。
// Swift の closure から Java callback interface 実装を直接生成できないため、
// callback 境界だけ Java 側に残している。
@JavaClass("com.example.item.CreativeTabRegistration")
open class JavaCreativeTabRegistration: JavaObject {}

extension JavaClass<JavaCreativeTabRegistration> {
    @JavaStaticMethod
    func addToIngredientsTab(_ items: [Item?])
}

@JavaClass("net.fabricmc.fabric.api.creativetab.v1.CreativeModeTabEvents")
open class FabricCreativeModeTabEvents: JavaObject {}

@JavaInterface("net.fabricmc.fabric.api.creativetab.v1.CreativeModeTabEvents$ModifyOutput")
struct FabricCreativeModeTabEventsModifyOutput {}

@JavaClass("net.fabricmc.fabric.api.creativetab.v1.FabricCreativeModeTabOutput")
open class FabricCreativeModeTabOutput: JavaObject {
    @JavaMethod
    open func accept(_ item: MinecraftItemLike?)
}

@JavaInterface("net.minecraft.world.level.ItemLike")
public struct MinecraftItemLike {}

@JavaClass("net.minecraft.world.item.CreativeModeTab")
open class MinecraftCreativeModeTab: JavaObject {}

@JavaClass("net.minecraft.world.item.CreativeModeTabs")
open class MinecraftCreativeModeTabs: JavaObject {}

extension JavaClass<MinecraftCreativeModeTabs> {
    @JavaStaticField(isFinal: true)
    var INGREDIENTS: ResourceKey<MinecraftCreativeModeTab>?
}

extension JavaClass<FabricCreativeModeTabEvents> {
    @JavaStaticMethod
    func modifyOutputEvent(
        _ resourceKey: ResourceKey<MinecraftCreativeModeTab>?
    ) -> FabricEvent<FabricCreativeModeTabEventsModifyOutput>?
}