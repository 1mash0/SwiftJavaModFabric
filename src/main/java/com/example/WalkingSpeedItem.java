package com.example;

import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.Level;
import com.example.swift.ModItemBridge;

public class WalkingSpeedItem extends Item {
    public WalkingSpeedItem(Properties properties) {
        super(properties);
    }

    @Override
    public InteractionResult use(
        Level level,
        Player player,
        InteractionHand hand
    ) {
        int result = ModItemBridge.changeWalkingSpeed(level, player);
        return switch (result) {
            case 0 -> InteractionResult.PASS;
            case 1 -> InteractionResult.SUCCESS;
            case 2 -> InteractionResult.CONSUME;
            default -> InteractionResult.FAIL;
        };
    }
}
