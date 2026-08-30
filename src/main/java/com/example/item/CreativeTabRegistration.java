package com.example.item;

import net.fabricmc.fabric.api.creativetab.v1.CreativeModeTabEvents;
import net.minecraft.world.item.CreativeModeTabs;
import net.minecraft.world.item.Item;

public class CreativeTabRegistration {
    public static void addToIngredientsTab(Item... items) {
        CreativeModeTabEvents
                .modifyOutputEvent(CreativeModeTabs.INGREDIENTS)
                .register((creativeTab) -> {
                    for (Item item : items) {
                        creativeTab.accept(item);
                    }
                });
    }

    private CreativeTabRegistration() {}
}
