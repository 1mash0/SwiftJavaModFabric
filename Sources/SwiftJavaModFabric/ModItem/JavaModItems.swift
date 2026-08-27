import MinecraftJavaAPI
import SwiftJava

@JavaClass("com.example.ModItems")
open class JavaModItems: JavaObject {}

extension JavaClass<JavaModItems> {
    @JavaStaticMethod
    func register(_ itemKey: ResourceKey<Item>?, _ item: Item?) -> Item!

    @JavaStaticMethod
    func addToIngredientsTab(_ items: [Item?])
}
