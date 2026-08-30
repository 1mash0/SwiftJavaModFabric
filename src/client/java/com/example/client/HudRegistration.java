package com.example.client;

import net.fabricmc.fabric.api.client.rendering.v1.hud.HudElementRegistry;
import net.minecraft.resources.Identifier;

import com.example.swift.HudRenderer;

public class HudRegistration {
    public static void register(Identifier id) {
        HudElementRegistry.addLast(
            id,
            (graphics, deltaTracker) -> {
                HudRenderer.render(graphics);
            }
        );
    }

    private HudRegistration() {}
}