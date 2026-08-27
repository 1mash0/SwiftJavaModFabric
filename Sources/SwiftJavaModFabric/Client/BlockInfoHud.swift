import SwiftJava

enum BlockInfoHud {
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
            let font = minecraft.font,
            let hitResult = minecraft.hitResult,
            let level = minecraft.level
        else {
            return
        }

        let hitResultTypeClass = try! JavaClass<MinecraftHitResultType>()
        guard
            let type = hitResult.getType(),
            let blockType = hitResultTypeClass.BLOCK,
            type.equals(blockType),
            let blockHitResult = hitResult.as(MinecraftBlockHitResult.self)
        else {
            return
        }

        guard
            let blockPos = blockHitResult.getBlockPos(),
            let blockState = level.getBlockState(blockPos),
            let block = blockState.getBlock(),
            let name = block.getName()?.getString()
        else {
            return
        }

        let x = (graphics.guiWidth() - font.width(name)) / 2
        let y = graphics.guiHeight() - 62

        graphics.text(
            font,
            name,
            x,
            y,
            -1,
            true
        )
    }
}