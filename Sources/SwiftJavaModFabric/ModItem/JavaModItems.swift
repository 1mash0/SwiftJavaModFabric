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

@JavaClass("com.example.item.BlockBreakerItem", extends: Item.self)
open class BlockBreakerItem: Item {}
