//
//  SeedRandomNumberGenerator+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
import Gen
@testable import SwiftChance

final class SeedRandomNumberGenerator_Tests: XCTestCase {
    // MARK: Test Utilities
    func scoreRNG(_ generator: Gen<UInt64>) -> Double {
        let numberOfAttempts = 1000
        
        let result = generator.set(ofAtMost: .always(1000)).run()
        
        return Double(result.count) / Double(numberOfAttempts)
    }
    // MARK: Test Cases
    func test_init_createsGeneratorBasedOnFormulaAndSeed() {
        let seed: Seed = .seed1D(24)
        let rng = SeedRandomNumberGenerator(seed)
        
        XCTAssertEqual(rng.seed.value, seed.value)
        XCTAssertEqual(rng.seed.position, seed.position)
        XCTAssertEqual(rng.formula(2,3), SeedRNG.squirrelFive(seed: 2, position: 3))
    }
    
    func test_advanceState_changesSeedState() {
        var rng = SeedRandomNumberGenerator(.seed3D(67))
        rng.advanceState()
        
        XCTAssertEqual(rng.seed.position, [1,0,0])
    }
    
    func test_peek_revealsNextValue() {
        let formula: SeedRandomNumberGenerator.Formula = { seed,_ in 9 }
        let rng = SeedRandomNumberGenerator(.seed1D(67), formula: formula)
        
        XCTAssertEqual(rng.peek(), 9)
    }
    // MARK: SeedRandomNumberGenerator: RandomNumberGenerator
    func test_next_returnsNextValueAdvancingState() {
        let formula: SeedRandomNumberGenerator.Formula = { seed,_ in 9 }
        var rng = SeedRandomNumberGenerator(.seed2D(67), formula: formula)
        let result = rng.next()
        
        XCTAssertEqual(result, 9)
        XCTAssertEqual(rng.seed.position, [1,0])
    }
    
    // MARK: Algorithms
    func test_squirrelThree_generatesUniqueValues() {
        var rng = SeedRandomNumberGenerator(.seed3D(67), formula: SeedRNG.squirrelThree)
        let generator: Gen<UInt64> = .f { rng.next() }
        let score = scoreRNG(generator)
        XCTAssertGreaterThanOrEqual(score, 0.8)
    }
    
    func test_squirrelFive_generatesUniqueValues() {
        var rng = SeedRandomNumberGenerator(.seed3D(67), formula: SeedRNG.squirrelFive)
        let generator: Gen<UInt64> = .f { rng.next() }
        let score = scoreRNG(generator)
        XCTAssertGreaterThanOrEqual(score, 0.8)
    }
}
