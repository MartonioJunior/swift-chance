# Chance

A library with utilities for randomness

## Table of Contents

  - [Features](#features)
  - [Installation](#installation)
  - [License](#license)

## Features
- New `Dice` alias for simulating dices and dice rolls
- `GeneratorDecoder` for generating values for any decodable type
- Seed-based RNG through `Seed` and `SeedRandomNumberGenerator`
- New `Randomizable` protocol for configuring objects based on received input
- Extensions for `Array`, `Collection`, `RandomNumberGenerator` and [swift-gen](https://github.com/pointfreeco/swift-gen) `Gen` type

## Installation

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage), you can add the following dependency to your `Cartfile`:

``` ruby
github "MartonioJunior/swift-chance" ~> 1.0
```

### SwiftPM

If you want to use Overture in a project that uses [SwiftPM](https://swift.org/package-manager/), it's as simple as adding a `dependencies` clause to your `Package.swift`:

``` swift
dependencies: [
  .package(url: "https://github.com/MartonioJunior/swift-chance.git", from: "1.0.0")
]
```

## License
This package is released under the MIT license. See [LICENSE](LICENSE) for details.

### Dependencies
The package depends on the following resources:
- [swift-gen](https://github.com/pointfreeco/swift-gen) by PointFree
