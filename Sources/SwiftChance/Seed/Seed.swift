//
//  Seed.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation

/// Structure that describes the state of a `SeedRandomNumberGenerator` seed.
public struct Seed {
    /// Position reference in the seed
    ///
    /// Reference positions are defined per-axis in a linear vector
    typealias Index = [UInt]
    
    // MARK: Variables
    /// The seed's value
    ///
    /// This value works as a fixed reference point for the values generated on every value request.
    let value: UInt
    /// The seed's position
    ///
    /// This value works as a mutable reference point for the values generated, changing after every value generated.
    var position: Index
    
    /// Simplified representation of position as a `UInt`
    ///
    /// `rawPosition` is used to compress all axises of `Index` into a single value that can be used by `SeedRandomNumberGenerator`, independent of how many axises are stored in the seed's state.
    var rawPosition: UInt {
        let multipliers: [UInt] = [1, 198491317, 6542989, 357239]

        return position.enumerated().reduce(0) { result, element in
            result &+ multipliers[element.0 % multipliers.count] * element.1
        }
    }
    
    // MARK: Initializers
    /// Creates a new seed state with the specified value and position
    /// - Parameters:
    ///   - value: fixed reference value for the seed
    ///   - position: seed's starting position
    internal init(value: UInt, position: Index) {
        self.value = value
        self.position = position
    }
    
    // MARK: Static Methods
    /// Creates a new unidimensional seed
    ///
    /// - Parameters:
    ///   - seed: fixed reference value for the seed
    ///   - position: seed's starting position
    /// - Returns: a new `Seed` instance
    static func seed1D(seed: UInt, position: UInt = 0) -> Seed {
        .init(value: seed, position: [position])
    }
    
    /// Creates a new bidimensional seed
    ///
    /// - Parameters:
    ///   - seed: fixed reference value for the seed
    ///   - position: seed's starting position
    /// - Returns: a new `Seed` instance
    static func seed2D(seed: UInt, position: SIMD2<UInt> = [0,0]) -> Seed {
        .init(value: seed, position: [position.x, position.y])
    }
    
    /// Creates a new tridimensional seed
    ///
    /// - Parameters:
    ///   - seed: fixed reference value for the seed
    ///   - position: seed's starting position
    /// - Returns: a new `Seed` instance
    static func seed3D(seed: UInt, position: SIMD3<UInt> = [0,0,0]) -> Seed {
        .init(value: seed, position: [position.x, position.y, position.z])
    }
    
    /// Creates a new 4-dimensional seed
    ///
    /// - Parameters:
    ///   - seed: fixed reference value for the seed
    ///   - position: seed's starting position
    /// - Returns: a new `Seed` instance
    static func seed4D(seed: UInt, position: SIMD4<UInt> = [0,0,0,0]) -> Seed {
        .init(value: seed, position: [position.x, position.y, position.z,position.w])
    }
}
