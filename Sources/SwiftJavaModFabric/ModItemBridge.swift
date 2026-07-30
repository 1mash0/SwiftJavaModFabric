import MinecraftJavaAPI
import SwiftJava

public enum ModItemBridge {
    public static func onUse(_ levelObject: JavaObject, _ playerObject: JavaObject) -> Int32 {
        let level = Level(javaThis: levelObject.javaThis, environment: levelObject.javaEnvironment)

        let message = try! JavaClass<Component>()

        // `literal` を使うと依存パッケージが増えるため、`nullToEmpty` を使う。
        if let message = try? JavaClass<Component>().nullToEmpty("テスト"), !level.isClientSide() {
            let player = Player(javaThis: playerObject.javaThis, environment: playerObject.javaEnvironment)
            player.sendOverlayMessage(message)
        }

        guard let serverPlayer = playerObject.as(ServerPlayer.self) else {
            return 2
        }

        ModItemService.showTitle(serverPlayer)

        return 0
    }
}