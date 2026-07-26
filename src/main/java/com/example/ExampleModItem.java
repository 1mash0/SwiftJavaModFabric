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

public class ExampleModItem extends Item {
    public ExampleModItem(Properties properties) {
        super(properties);
    }

    @Override
    @NonNull
    public InteractionResult use(Level level, Player player, InteractionHand hand) {
        if (!level.isClientSide()) {
            player.sendOverlayMessage(Component.literal("テスト"));
        }

        if (player instanceof ServerPlayer serverPlayer) {
            showTitle(serverPlayer);
        }

        return InteractionResult.SUCCESS;
    }

    private static void showTitle(ServerPlayer player) {
        player.connection.send(new ClientboundSetTitlesAnimationPacket(10, 60, 20));
        player.connection.send(new ClientboundSetTitleTextPacket(Component.literal("Title")));
        player.connection.send(new ClientboundSetSubtitleTextPacket(Component.literal("Sub Title")));
    }
}
