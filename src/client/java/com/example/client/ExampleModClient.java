package com.example.client;

import net.fabricmc.api.ClientModInitializer;

import net.fabricmc.fabric.api.client.rendering.v1.hud.HudElementRegistry;
import net.minecraft.resources.Identifier;

import com.example.ExampleMod;
import com.example.swift.ClockHud;

public class ExampleModClient implements ClientModInitializer {
    @Override
    public void onInitializeClient() {
        HudElementRegistry.addLast(
            Identifier.fromNamespaceAndPath(ExampleMod.MOD_ID, "clock"),
            (graphics, deltaTracker) -> {
                ClockHud.render(graphics);
            }
        );
    }
}