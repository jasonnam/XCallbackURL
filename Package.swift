// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "XCallbackURL",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "XCallbackURL",
            targets: ["XCallbackURL"])
    ],
    targets: [
        .target(
            name: "XCallbackURL",
            dependencies: [])
    ]
)
