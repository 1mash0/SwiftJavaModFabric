package com.example;

import net.minecraft.network.chat.Component;
import net.minecraft.network.protocol.game.ClientboundSetSubtitleTextPacket;
import net.minecraft.network.protocol.game.ClientboundSetTitleTextPacket;
import net.minecraft.network.protocol.game.ClientboundSetTitlesAnimationPacket;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.Level;
import org.jspecify.annotations.NonNull;
import com.example.swift.ModItemBridge;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExampleModItem extends Item {

	public static final Logger LOGGER = LoggerFactory.getLogger("swift-java-mod-fabric");

    public ExampleModItem(Properties properties) {
        super(properties);
    }

    @Override
    @NonNull
    public InteractionResult use(Level level, Player player, InteractionHand hand) {
        int result = ModItemBridge.onUse(level, player);
        return switch (result) {
            case 0 -> InteractionResult.PASS;
            case 1 -> InteractionResult.SUCCESS;
            case 2 -> InteractionResult.CONSUME;
            default -> InteractionResult.FAIL;
        };
        
        // if (!level.isClientSide()) {
        //     player.sendOverlayMessage(Component.literal("テスト"));
        //     System.out.println(SwiftBridge.onUse(level, player));
        // }

        // if (player instanceof ServerPlayer serverPlayer) {
        //     showTitle(serverPlayer);
        // }

        // return InteractionResult.SUCCESS;
    }

    // private static void showTitle(ServerPlayer player) {
    //     player.connection.send(new ClientboundSetTitlesAnimationPacket(10, 60, 20));

    //     String message = SwiftBridge.hello();
    //     player.connection.send(new ClientboundSetTitleTextPacket(Component.literal(message)));
    //     player.connection.send(new ClientboundSetSubtitleTextPacket(Component.literal("Sub Title")));
    // }
}
