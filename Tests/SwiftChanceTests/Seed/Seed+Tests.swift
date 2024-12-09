//
//  Seed+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import Testing
@testable import SwiftChance

struct SeedTests {
    @Test("Transforms Index Array Into Single Value", arguments: [
        (Seed(value: 24, position: [4,0,0,2,8,9,2,2]), UInt(1800936799))
    ])
    func rawPosition(seed: Seed, outcome: UInt) async throws {
        #expect(seed.rawPosition == outcome)
    }
    
    @Test("Creates New Seed with Index", arguments: [
        (Seed(value: 13, position: [2,3,1]), UInt(13), [2,3,1])
    ])
    func `init`(seed: Seed, value: UInt, position: [UInt]) async throws {
        #expect(seed.value == value)
        #expect(seed.position == position)
    }
    
    @Test("Initializes One Dimensional Seed", arguments: [
        (Seed.seed1D(12), UInt(12), [0])
    ])
    func seed1D(seed: Seed, value: UInt, position: [UInt]) async throws {
        let seed: Seed = .seed1D(12)
        
        #expect(seed.value == value)
        #expect(seed.position == position)
    }
    
    @Test("Initializes Two Dimensional Seed", arguments: [
        (Seed.seed2D(4), UInt(4), [0,0])
    ])
    func seed2D(seed: Seed, value: UInt, position: [UInt]) async throws {
        #expect(seed.value == value)
        #expect(seed.position == position)
    }
    
    @Test("Initializes Three Dimensional Seed", arguments: [
        (Seed.seed3D(98), UInt(98), [0,0,0])
    ])
    func seed3D(seed: Seed, value: UInt, position: [UInt]) async throws {
        #expect(seed.value == value)
        #expect(seed.position == position)
    }
    
    @Test("Initializes Four Dimensional Seed", arguments: [
        (Seed.seed4D(9), UInt(9), [0,0,0,0])
    ])
    func seed4D(seed: Seed, value: UInt, position: [UInt]) async throws {
        #expect(seed.value == value)
        #expect(seed.position == position)
    }
}
