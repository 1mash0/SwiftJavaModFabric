package com.example;

import net.fabricmc.api.ModInitializer;

import net.minecraft.resources.Identifier;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.example.item.ModItems;
import com.example.swift.SwiftBridge;

public class ExampleMod implements ModInitializer {
	public static final String MOD_ID = "swift-java-mod-fabric";
	public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

	@Override
	public void onInitialize() {
		LOGGER.info("Hello Fabric world!");
		LOGGER.info(SwiftBridge.hello());

		// Initialize mod items
		ModItems.initialize();
		com.example.swift.ModItems.initialize();

		// Register creative tabs
		ModItems.registerCreativeTab();
		com.example.swift.ModItems.registerCreativeTab();
	}

	public static Identifier id(String path) {
		return Identifier.fromNamespaceAndPath(MOD_ID, path);
	}
}
