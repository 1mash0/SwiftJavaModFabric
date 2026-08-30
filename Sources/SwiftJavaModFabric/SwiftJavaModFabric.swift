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

    let javaModItemsClass = try! JavaClass<JavaModItems>()

    // Java側で実装しているItemを初期化
    javaModItemsClass.initialize()
    // Swift側で実装しているItemを初期化
    ModItems.initialize()

    // Java側で実装しているItemをクリエイティブタブに登録
    javaModItemsClass.registerCreativeTab()
    // Swift側で実装しているItemをクリエイティブタブに登録
    ModItems.registerCreativeTab()
}

public func initializeClientMod() {
    let identifierClass = try! JavaClass<Identifier>()
    let hudRegistrationClass = try! JavaClass<JavaHudRegistration>()

    let hudId = identifierClass.fromNamespaceAndPath(modID, "hud")

    hudRegistrationClass.register(hudId)
}