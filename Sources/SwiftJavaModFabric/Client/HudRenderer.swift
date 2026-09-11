import SwiftJava

public enum HudRenderer {
    public static func renderHudElement(
        _ graphicsObject: JavaObject,
        _ deltaTrackerObject: JavaObject
    ) {
        ClockHud.render(graphicsObject)
        BlockInfoHud.render(graphicsObject)
    }
}