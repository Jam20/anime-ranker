// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "anime-ranker-swift",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.78.0"),
        .package(url: "https://github.com/pointfreeco/swift-html-vapor", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "anime-ranker-swift",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "HtmlVaporSupport", package: "swift-html-vapor")
            ],
            path: "Sources"),
    ]
)
