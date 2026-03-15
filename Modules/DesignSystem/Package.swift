// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(name: "DesignSystemCore", targets: ["DesignSystemCore"]),
        .library(name: "DesignSystemIOS", targets: ["DesignSystemIOS"])
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", exact: "2.2.7")
    ],
    targets: [
        .target(
            name: "DesignSystemCore",
            dependencies: ["Core"]
        ),
        .target(
            name: "DesignSystemIOS",
            dependencies: [
                "DesignSystemCore",
                "Core",
                "SDWebImageSwiftUI"
            ]
        )
    ]
)
