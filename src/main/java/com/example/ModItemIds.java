package com.example;

import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.item.Item;

public class ModItemIds {
    public static final ResourceKey<Item> SUSPICIOUS_SUBSTANCE = create("suspicious_substance");
    public static final ResourceKey<Item> EXAMPLE_MOD_ITEM = create("example_mod_item");

    public static ResourceKey<Item> create(String name) {
        return ResourceKey.create(Registries.ITEM, Identifier.fromNamespaceAndPath(ExampleMod.MOD_ID, name));
    }
}
