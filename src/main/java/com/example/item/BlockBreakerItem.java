package com.example.item;

import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;

import org.jetbrains.annotations.Nullable;

import com.example.swift.ModItemBridge;

public class BlockBreakerItem extends Item {
    public BlockBreakerItem(Properties properties) {
        super(properties);
    }

    @Override
    public void inventoryTick(
        ItemStack itemStack, 
        ServerLevel level, 
        Entity owner,
        @Nullable EquipmentSlot slot
    ) {
        super.inventoryTick(itemStack, level, owner, slot);

        if (slot == EquipmentSlot.MAINHAND && owner instanceof ServerPlayer player) {
            ModItemBridge.onPlayerTick(player);
        }
    }
}
