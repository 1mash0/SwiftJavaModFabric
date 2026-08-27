package com.example.item;

import com.example.ExampleMod;

import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.item.Item;

public class ModItemIds {
    public static final ResourceKey<Item> SUSPICIOUS_SUBSTANCE = create("suspicious_substance");
    public static final ResourceKey<Item> SWIFT_BRIDGE_ITEM = create("swift_bridge_item");
    public static final ResourceKey<Item> WALKING_SPEED_ITEM = create("walking_speed_item");
    public static final ResourceKey<Item> BLOCK_BREAKER_ITEM = create("block_breaker_item");
    public static final ResourceKey<Item> IOSDC_BADGE_ITEM = create("iosdc_badge_item");

    public static ResourceKey<Item> create(String name) {
        return ResourceKey.create(Registries.ITEM, Identifier.fromNamespaceAndPath(ExampleMod.MOD_ID, name));
    }
}
