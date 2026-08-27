import Foundation
import SwiftJava

enum ClockHud {
    static func render(
        _ graphicsObject: JavaObject
    ) {
        guard
            let graphics = graphicsObject.as(MinecraftGuiGraphicsExtractor.self)
        else {
            return
        }

        let minecraftClass = try! JavaClass<MinecraftClient>()
        guard
            let minecraft = minecraftClass.getInstance(),
            let font = minecraft.font
        else {
            return
        }

        let time = Date.now.formatted(
            Date.FormatStyle()
                .hour(.defaultDigits(amPM: .omitted))
                .minute(.twoDigits)
                .second(.twoDigits)
        )

        let padding: Int32 = 8
        let x = graphics.guiWidth() - font.width(time) - padding
        let y: Int32 = 8

        graphics.text(
            font,
            time,
            x,
            y,
            -1,
            true
        )
    }
}