import Foundation
import SwiftJava

public enum ClockHud {
    public static func render(
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

        graphics.text(
            font,
            time,
            8,
            8,
            -1,
            true
        )
    }
}