package com.example;

import net.fabricmc.fabric.api.creativetab.v1.CreativeModeTabEvents;
import net.minecraft.core.Registry;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.item.CreativeModeTabs;
import net.minecraft.world.item.Item;

import java.util.function.Function;

public class ModItems {
    public static final Item SUSPICIOUS_SUBSTANCE = register(ModItemIds.SUSPICIOUS_SUBSTANCE, Item::new, new Item.Properties());
    public static final Item SWIFT_BRIDGE_ITEM = register(ModItemIds.SWIFT_BRIDGE_ITEM, SwiftBridgeItem::new, new Item.Properties());
    public static final Item WALKING_SPEED_ITEM = register(ModItemIds.WALKING_SPEED_ITEM, WalkingSpeedItem::new, new Item.Properties());
    public static final Item BLOCK_BREAKER_ITEM = register(ModItemIds.BLOCK_BREAKER_ITEM, BlockBreakerItem::new, new Item.Properties());
    public static final Item IOSDC_BADGE_ITEM = register(ModItemIds.IOSDC_BADGE_ITEM, IOSDCBadgeItem::new, new Item.Properties());

    public static Item register(ResourceKey<Item> itemKey, Function<Item.Properties, Item> itemFactory, Item.Properties settings) {
        Item item = itemFactory.apply(settings.setId(itemKey));
        Registry.register(BuiltInRegistries.ITEM, itemKey, item);

        return item;
    }

    public static void initialize() {
        // Get the event for modifying entries in the ingredients group.
        // And register an event handler that adds our suspicious item to the ingredients group.
        CreativeModeTabEvents
                .modifyOutputEvent(CreativeModeTabs.INGREDIENTS)
                .register((creativeTab) -> {
                    creativeTab.accept(ModItems.SUSPICIOUS_SUBSTANCE);
                    creativeTab.accept(ModItems.SWIFT_BRIDGE_ITEM);
                    creativeTab.accept(ModItems.WALKING_SPEED_ITEM);
                    creativeTab.accept(ModItems.BLOCK_BREAKER_ITEM);
                    creativeTab.accept(ModItems.IOSDC_BADGE_ITEM);
                });
    }

    private ModItems() {}
}
