// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let chanceDependencies: [Target.Dependency] = [
    .product(name: "Gen", package: "swift-gen")
]

let settings: [SwiftSetting] = [
    .enableUpcomingFeature("GlobalActorIsolatedTypesUsability"),
    .enableUpcomingFeature("FullTypedThrows"),
    .enableUpcomingFeature("InternalImportsByDefault")
]

let package = Package(
    name: "SwiftChance",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftChance",
            targets: ["SwiftChance"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-gen.git", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftChance",
            dependencies: chanceDependencies,
            swiftSettings: settings
        ),
        .testTarget(
            name: "SwiftChanceTests",
            dependencies: ["SwiftChance"]),
    ]
)
