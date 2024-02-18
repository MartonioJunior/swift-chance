//
//  Seed.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation

public struct Seed {
    typealias Index = [UInt]
    
    // MARK: Variables
    var value: UInt
    var position: Index
    
    var rawPosition: UInt {
        let multipliers: [UInt] = [1, 198491317, 6542989, 357239]

        return position.enumerated().reduce(0) { result, element in
            result + multipliers[element.0 % multipliers.count] * element.1
        }
    }
    
    // MARK: Initializers
    internal init(value: UInt, position: Index) {
        self.value = value
        self.position = position
    }
    
    // MARK: Static Methods
    static func seed1D(seed: UInt, position: UInt = 0) -> Seed {
        .init(value: seed, position: [position])
    }
    
    static func seed2D(seed: UInt, position: SIMD2<UInt> = [0,0]) -> Seed {
        .init(value: seed, position: [position.x, position.y])
    }
    
    static func seed3D(seed: UInt, position: SIMD3<UInt> = [0,0,0]) -> Seed {
        .init(value: seed, position: [position.x, position.y, position.z])
    }
    
    static func seed4D(seed: UInt, position: SIMD4<UInt> = [0,0,0,0]) -> Seed {
        .init(value: seed, position: [position.x, position.y, position.z,position.w])
    }
}

// MARK: IteratorProtocol
extension Seed: IteratorProtocol {
    public mutating func next() -> Self? {
        position[0] += 1
        return self
    }
}
