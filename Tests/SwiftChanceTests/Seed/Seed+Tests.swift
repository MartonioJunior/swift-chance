//
//  Seed+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
@testable import SwiftChance

final class Seed_Tests: XCTestCase {
    // MARK: Test Cases
    func test_rawPosition_transformsIndexArrayIntoSingleValue() {
        let seed = Seed(value: 24, position: [4,0,0,2,8,9,2,2])
        
        XCTAssertEqual(seed.rawPosition, 1800936799)
    }
    
    func test_init_createsNewSeedWithIndex()
    {
        let seed = Seed(value: 13, position: [2,3,1])
        
        XCTAssertEqual(seed.value, 13)
        XCTAssertEqual(seed.position, [2,3,1])
    }
    
    func test_seed1D_initializesOneDimensionalSeed() {
        let seed: Seed = .seed1D(seed: 12)
        
        XCTAssertEqual(seed.value, 12)
        XCTAssertEqual(seed.position, [0])
    }

    func test_seed2D_initializesTwoDimensionalSeed() {
        let seed: Seed = .seed2D(seed: 4)
        
        XCTAssertEqual(seed.value, 4)
        XCTAssertEqual(seed.position, [0,0])
    }

    func test_seed3D_initializesThreeDimensionalSeed() {
        let seed: Seed = .seed3D(seed: 98)
        
        XCTAssertEqual(seed.value, 98)
        XCTAssertEqual(seed.position, [0,0,0])
    }

    func test_seed4D_initializesFourDimensionalSeed() {
        let seed: Seed = .seed4D(seed: 9)
        
        XCTAssertEqual(seed.value, 9)
        XCTAssertEqual(seed.position, [0,0,0,0])
    }
}
