// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftJavaModFabric",
    platforms: [.macOS(.v26)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MinecraftJavaAPI",
            type: .dynamic,
            targets: ["MinecraftJavaAPI"]
        ),
        .library(
            name: "SwiftJavaModFabric",
            type: .dynamic,
            targets: ["SwiftJavaModFabric"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-java", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MinecraftJavaAPI",
            dependencies: [
                .product(name: "SwiftJava", package: "swift-java"),
                .product(name: "JavaUtilFunction", package: "swift-java"),
                .product(name: "JavaUtilJar", package: "swift-java"),
            ],
            exclude: [
                "swift-java.config"
            ],
            plugins: [
                .plugin(name: "JavaCompilerPlugin", package: "swift-java"),
                .plugin(name: "SwiftJavaPlugin", package: "swift-java"),
            ]
        ),
        .target(
            name: "SwiftJavaModFabric",
            dependencies: [
                "MinecraftJavaAPI",
                .product(name: "SwiftJava", package: "swift-java"),
                .product(name: "SwiftRuntimeFunctions", package: "swift-java"),
            ],
            exclude: [
                "swift-java.config"
            ],
            plugins: [
                .plugin(name: "JExtractSwiftPlugin", package: "swift-java"),
            ]
        ),
        .testTarget(
            name: "SwiftJavaModTests",
            dependencies: ["SwiftJavaModFabric", "MinecraftJavaAPI"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
