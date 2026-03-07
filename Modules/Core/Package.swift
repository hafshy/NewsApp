// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", exact: "2.2.7"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.8.0"),
        .package(url: "https://github.com/SwiftKickMobile/SwiftMessages.git", exact: "9.0.9")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                "SDWebImageSwiftUI",
                "Alamofire",
                "SwiftMessages"
            ]
        )
    ]
)

