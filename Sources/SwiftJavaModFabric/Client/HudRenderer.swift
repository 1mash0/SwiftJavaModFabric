import SwiftJava

public enum HudRenderer {
    public static func render(
        _ graphicsObject: JavaObject
    ) {
        ClockHud.render(graphicsObject)
        BlockInfoHud.render(graphicsObject)
    }
}