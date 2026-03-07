// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "News",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "News",
            targets: ["News"]
        ),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "News",
            dependencies: [
                "Core",
                .product(name: "DesignSystemCore", package: "DesignSystem"),
                .product(name: "DesignSystemIOS", package: "DesignSystem")
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
