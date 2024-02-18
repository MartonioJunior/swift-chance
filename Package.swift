// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let chanceDependencies: [Target.Dependency] = [
    .product(name: "Gen", package: "swift-gen")
]

let package = Package(
    name: "Chance",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Chance",
            targets: ["Chance"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-gen.git", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Chance",
            dependencies: chanceDependencies
        ),
        .testTarget(
            name: "ChanceTests",
            dependencies: ["Chance"]),
    ]
)