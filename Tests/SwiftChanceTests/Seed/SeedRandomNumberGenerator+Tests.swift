//
//  SeedRandomNumberGenerator+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct SeedRandomNumberGeneratorTests {
    @Test("Creates Generator Based on Formula and Seed", arguments: [
        (Seed.seed1D(24), SeedRNG.squirrelFive)
    ])
    func `init`(seed: Seed, formula: @escaping SeedRNG.Formula) async throws {
        let rng = SeedRandomNumberGenerator(seed, formula: formula)
        
        #expect(rng.seed == seed)
        #expect(rng.formula(1,2) == formula(1,2))
    }
    
    @Test("Changes Seed State", arguments: [
        (SeedRandomNumberGenerator(.seed3D(67)), [1,0,0])
    ])
    func advanceState(seedRNG: SeedRandomNumberGenerator, expectedPosition: [UInt]) async throws {
        var rng = seedRNG
        rng.advanceState()
        #expect(rng.seed.position == expectedPosition)
    }
    
    @Test("Reveals next value", arguments: [
        (Seed.seed1D(67), 9)
    ])
    func peek(seed: Seed, outcome: Int) async throws {
        let rng = SeedRandomNumberGenerator(seed, formula: { _,_ in UInt64(outcome) })
        #expect(rng.peek() == outcome)
    }
    
    @Suite("RandomNumberGenerator conformance")
    struct RandomNumberGenerator {
        @Test("Returns next value advancing state", arguments: [
            (Seed.seed2D(67), 9, [1,0])
        ])
        func next(seed: Seed, outcome: Int, expectedPosition: [UInt]) async throws {
            var rng = SeedRandomNumberGenerator(seed, formula: { _,_ in UInt64(outcome) })
            let result = rng.next()
            #expect(result == outcome)
            #expect(rng.seed.position == expectedPosition)
        }
    }
    
    @Suite("Formulas Implemented")
    struct Formula {
        func score(_ generator: Gen<UInt64>) -> Double {
            let numberOfAttempts = 1000
            
            let result = generator.set(ofAtMost: .always(1000)).run()
            
            return Double(result.count) / Double(numberOfAttempts)
        }
        
        @Test("Must have a 80% score or above", arguments: [
            (Seed.seed3D(67), SeedRNG.squirrelThree, 0.8),
            (Seed.seed3D(223), SeedRNG.squirrelFive, 0.8)
        ])
        func firstGuideline(seed: Seed, formula: @escaping SeedRNG.Formula, expectedScore: Double) async throws {
            var rng = SeedRandomNumberGenerator(seed, formula: formula)
            let generator: Gen<UInt64> = .f { rng.next() }
            let score = score(generator)
            #expect(score >= expectedScore)
        }
    }
}
