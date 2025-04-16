//
//  SeedableRandomNumberGenerator.swift
//
//
//  Created by Martônio Júnior on 07/10/23.
//

import Foundation

public typealias SeedRNG = SeedRandomNumberGenerator

/// Customizable `RandomNumberGenerator` powered by `Seed` and custom formulas
public struct SeedRandomNumberGenerator {
    /// Equation used to generate random values based on a seed's value and it's raw position
    public typealias Formula = @Sendable (UInt, UInt) -> UInt64

    // MARK: Variables
    /// Formula used by this generator
    internal let formula: Formula
    /// Current seed for the generator
    public private(set) var seed: Seed

    // MARK: Initializers
    /// Creates a new `SeedRandomNumberGenerator` with a defined state and it's respective formula
    /// - Parameters:
    ///   - seed: current seed for generator
    ///   - formula: formula used by the generator to create new values
    public init(_ seed: Seed, formula: @escaping Formula = Self.squirrelFive) {
        self.seed = seed
        self.formula = formula
    }

    // MARK: Methods
    /// Advances state for the generator's seed
    mutating func advanceState() {
        seed.position[0] += 1
    }

    /// Shows the next value of the generator without advancing state.
    /// - Returns: The generator's next value
    public func peek() -> UInt64 { formula(seed.value, seed.rawPosition) }
}

// MARK: RandomNumberGenerator
extension SeedRandomNumberGenerator: RandomNumberGenerator {
    mutating public func next() -> UInt64 {
        let value = peek()
        advanceState()
        return value
    }
}

// MARK: Sendable
extension SeedRandomNumberGenerator: Sendable {}

// MARK: Algorithms
public extension SeedRandomNumberGenerator {
    /// Distribution algorithm that generates a new value by mangling values and adding noise
    /// Concept adapted from Squirrel Eiserloh's talk
    /// about [Noise-Based RNG]( https://www.youtube.com/watch?v=LWFzPP8ZbdU)
    ///
    /// - Parameters:
    ///   - seed: the seed's value
    ///   - position: the raw position of the seed
    /// - Returns: a newly generated value
    static func squirrelThree(seed: UInt, position: UInt) -> UInt64 {
        let firstBitNoise: UInt = 0xB5297A4D
        let secondBitNoise: UInt = 0x68E31DA4
        let thirdBitNoise: UInt = 0x1B56C4E9

        var mangled: UInt = position
        mangled &*= firstBitNoise
        mangled &+= seed
        mangled ^= (mangled >> 8)
        mangled &*= secondBitNoise
        mangled ^= (mangled << 8)
        mangled &*= thirdBitNoise
        mangled ^= (mangled >> 8)
        return UInt64(mangled)
    }

    /// Evolution of Squirrel3 that allows for more interesting and better distributed values.
    /// Adapted from Squirrel Eiserloh's C++ implementation
    /// of [SquirrelNoise5](http://eiserloh.net/noise/SquirrelNoise5.hpp), original code
    /// licensed under [CC-BY-3.0](https://creativecommons.org/licenses/by/3.0/us/)
    ///
    /// - Parameters:
    ///   - seed: the seed's value
    ///   - position: the raw position of the seed
    /// - Returns: a newly generated value
    static func squirrelFive(seed: UInt, position: UInt) -> UInt64 {
        let sq5BitNoise1: UInt = 0xd2a80a3f // 11010010101010000000101000111111
        let sq5BitNoise2: UInt = 0xa884f197 // 10101000100001001111000110010111
        let sq5BitNoise3: UInt = 0x6C736F4B // 01101100011100110110111101001011
        let sq5BitNoise4: UInt = 0xB79F3ABB // 10110111100111110011101010111011
        let sq5BitNoise5: UInt = 0x1b56c4f5 // 00011011010101101100010011110101

        var mangledBits: UInt = position
        mangledBits &*= sq5BitNoise1
        mangledBits &+= seed
        mangledBits ^= (mangledBits >> 9)
        mangledBits &+= sq5BitNoise2
        mangledBits ^= (mangledBits >> 11)
        mangledBits &*= sq5BitNoise3
        mangledBits ^= (mangledBits >> 13)
        mangledBits &+= sq5BitNoise4
        mangledBits ^= (mangledBits >> 15)
        mangledBits &*= sq5BitNoise5
        mangledBits ^= (mangledBits >> 17)
        return UInt64(mangledBits)
    }
}
