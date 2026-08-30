import MinecraftJavaAPI
import SwiftJava

public enum SwiftBridge {
    public static func hello() -> String {
        "Hello from Swift!"
    }
}

let modID = "swift-java-mod-fabric"

public func initializeMod() {
    ModLogger.info("Hello Fabric world from Swift!")

    ModItem.initialize()
}

public func initializeClientMod() {
    let identifierClass = try! JavaClass<Identifier>()
    let hudRegistrationClass = try! JavaClass<JavaHudRegistration>()

    let hudId = identifierClass.fromNamespaceAndPath(modID, "hud")

    hudRegistrationClass.register(hudId)
}