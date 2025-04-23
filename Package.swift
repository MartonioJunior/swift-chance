// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let chanceDependencies: [Target.Dependency] = [
    .product(name: "Gen", package: "swift-gen"),
    .product(name: "NonEmpty", package: "swift-nonempty")
]

let settings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
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
        .library(
            name: "SwiftChance",
            targets: ["SwiftChance"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-gen.git", from: "0.4.0"),
        .package(url: "https://github.com/pointfreeco/swift-nonempty", .upToNextMajor(from: "0.5.0"))
    ],
    targets: [
        .target(
            name: "SwiftChance",
            dependencies: chanceDependencies,
            swiftSettings: settings
        ),
        .testTarget(
            name: "SwiftChanceTests",
            dependencies: ["SwiftChance"]
        )
    ],
    swiftLanguageModes: [.v6]
)
