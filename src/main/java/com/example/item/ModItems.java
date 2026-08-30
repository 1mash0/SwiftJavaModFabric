package com.example.item;

import net.fabricmc.fabric.api.creativetab.v1.CreativeModeTabEvents;
import net.minecraft.core.Registry;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.item.CreativeModeTabs;
import net.minecraft.world.item.Item;

import java.util.function.Function;

import com.example.swift.ModItemIds;

public class ModItems {
    public static final Item SUSPICIOUS_SUBSTANCE = register(
        itemKey(ModItemIds.getSuspiciousSubstance()),
        Item::new,
        new Item.Properties()
    );
    public static final Item SWIFT_BRIDGE_ITEM = register(
        itemKey(ModItemIds.getSwiftBridgeItem()),
        SwiftBridgeItem::new,
        new Item.Properties()
    );
    public static final Item WALKING_SPEED_ITEM = register(
        itemKey(ModItemIds.getWalkingSpeedItem()),
        WalkingSpeedItem::new,
        new Item.Properties()
    );
    public static final Item BLOCK_BREAKER_ITEM = register(
        itemKey(ModItemIds.getBlockBreakerItem()),
        BlockBreakerItem::new,
        new Item.Properties()
    );
    public static final Item IOSDC_BADGE_ITEM = register(
        itemKey(ModItemIds.getIosdcBadgeItem()),
        IOSDCBadgeItem::new,
        new Item.Properties()
    );

    public static Item register(ResourceKey<Item> itemKey, Function<Item.Properties, Item> itemFactory, Item.Properties settings) {
        Item item = itemFactory.apply(settings.setId(itemKey));
        Registry.register(BuiltInRegistries.ITEM, itemKey, item);

        return item;
    }

    public static void initialize() {}

    public static void registerCreativeTab() {
        addToIngredientsTab(
                SUSPICIOUS_SUBSTANCE,
                SWIFT_BRIDGE_ITEM,
                WALKING_SPEED_ITEM,
                BLOCK_BREAKER_ITEM,
                IOSDC_BADGE_ITEM
        );
    }

    public static void addToIngredientsTab(Item... items) {
        CreativeModeTabEvents
                .modifyOutputEvent(CreativeModeTabs.INGREDIENTS)
                .register((creativeTab) -> {
                    for (Item item : items) {
                        creativeTab.accept(item);
                    }
                });
    }

    @SuppressWarnings("unchecked")
    private static ResourceKey<Item> itemKey(ResourceKey<?> key) {
        return (ResourceKey<Item>) key;
    }

    private ModItems() {}
}
