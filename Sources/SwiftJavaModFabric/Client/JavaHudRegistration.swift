import MinecraftJavaAPI
import SwiftJava

@JavaClass("com.example.client.HudRegistration")
open class JavaHudRegistration: JavaObject {}

extension JavaClass<JavaHudRegistration> {
    @JavaStaticMethod
    func register(_ id: Identifier?)
}