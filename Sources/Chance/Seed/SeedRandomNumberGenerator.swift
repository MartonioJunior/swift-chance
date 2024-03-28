//
//  SeedableRandomNumberGenerator.swift
//
//
//  Created by Martônio Júnior on 07/10/23.
//

import Foundation

public typealias SeedRNG = SeedRandomNumberGenerator

public struct SeedRandomNumberGenerator {
    public typealias Formula = (UInt, UInt) -> UInt64

    // MARK: Variables
    internal let formula: Formula
    public private(set) var seed: Seed

    // MARK: Initializers
    public init(_ seed: Seed, formula: @escaping Formula = Self.squirrelFive) {
        self.seed = seed
        self.formula = formula
    }
    
    // MARK: Methods
    mutating func advanceState() {
        seed.position[0] += 1
    }
    
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

// MARK: Algorithms
public extension SeedRandomNumberGenerator {
    static func squirrelThree(seed: UInt, position: UInt) -> UInt64 {
        let firstBitNoise: UInt = 0xB5297A4D;
        let secondBitNoise: UInt = 0x68E31DA4;
        let thirdBitNoise: UInt = 0x1B56C4E9;
        
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
    
    static func squirrelFive(seed: UInt, position: UInt) -> UInt64 {
        let SQ5_BIT_NOISE1: UInt = 0xd2a80a3f;    // 11010010101010000000101000111111
        let SQ5_BIT_NOISE2: UInt = 0xa884f197;    // 10101000100001001111000110010111
        let SQ5_BIT_NOISE3: UInt = 0x6C736F4B;    // 01101100011100110110111101001011
        let SQ5_BIT_NOISE4: UInt = 0xB79F3ABB;    // 10110111100111110011101010111011
        let SQ5_BIT_NOISE5: UInt = 0x1b56c4f5;    // 00011011010101101100010011110101
        
        var mangledBits: UInt = position;
        mangledBits &*= SQ5_BIT_NOISE1;
        mangledBits &+= seed;
        mangledBits ^= (mangledBits >> 9);
        mangledBits &+= SQ5_BIT_NOISE2;
        mangledBits ^= (mangledBits >> 11);
        mangledBits &*= SQ5_BIT_NOISE3;
        mangledBits ^= (mangledBits >> 13);
        mangledBits &+= SQ5_BIT_NOISE4;
        mangledBits ^= (mangledBits >> 15);
        mangledBits &*= SQ5_BIT_NOISE5;
        mangledBits ^= (mangledBits >> 17);
        return UInt64(mangledBits);
    }
}
