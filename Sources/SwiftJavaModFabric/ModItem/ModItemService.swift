import MinecraftJavaAPI
import SwiftJava

enum ModItemService {
    static func showTitle(_ player: ServerPlayer, title: String, subtitle: String? = nil) {
        guard 
            let component = try? JavaClass<Component>(),
            let title = component.nullToEmpty(title),
            let subtitle = component.nullToEmpty(subtitle ?? "")
        else {
            return
        }
        
        let animationPacket = ClientboundSetTitlesAnimationPacket(10, 60, 20).as(Packet<JavaObject>.self)
        let titlePacket = ClientboundSetTitleTextPacket(title).as(Packet<JavaObject>.self)
        let subTitlePacket = ClientboundSetSubtitleTextPacket(subtitle).as(Packet<JavaObject>.self)

        player.connection.send(animationPacket)
        player.connection.send(titlePacket)
        player.connection.send(subTitlePacket)
    }
}