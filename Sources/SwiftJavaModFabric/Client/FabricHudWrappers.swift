import MinecraftJavaAPI
import SwiftJava

@JavaInterface("net.fabricmc.fabric.api.client.rendering.v1.hud.HudElement")
struct FabricHudElement {}
    
@JavaInterface("net.fabricmc.fabric.api.client.rendering.v1.hud.HudElementRegistry")
struct FabricHudElementRegistry {}

extension JavaClass<FabricHudElementRegistry> {
    @JavaStaticMethod
    func addLast(
        _ id: Identifier?,
        _ element: FabricHudElement?
    )
}

@JavaInterface(
    "net.fabricmc.loader.api.ModContainer"
)
struct FabricModContainer {}

@JavaInterface("net.fabricmc.loader.api.LanguageAdapter")
struct FabricLanguageAdapter {
    @JavaMethod(
        typeErasedResult: "T!",
        typeErasedResultBound: JavaObject?.self
    )
    func create<T: AnyJavaObject>(
        _ mod: FabricModContainer?,
        _ value: String,
        _ type: JavaClass<T>?
    ) throws -> T!
}

extension JavaClass<FabricLanguageAdapter> {
    @JavaStaticMethod
    func getDefault() -> FabricLanguageAdapter?
}

@JavaInterface("net.fabricmc.loader.api.FabricLoader")
struct FabricLoader {
    @JavaMethod
    func getModContainer(
        _ id: String
    ) -> JavaOptional<FabricModContainer>?
}

extension JavaClass<FabricLoader> {
    @JavaStaticMethod
    func getInstance() -> FabricLoader?
}