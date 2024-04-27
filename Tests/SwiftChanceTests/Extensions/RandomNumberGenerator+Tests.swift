//
//  RandomNumberGenerator+Tests.swift
//  
//
//  Created by Martônio Júnior on 20/02/24.
//

import XCTest
@testable import Gen
@testable import Chance

final class RandomNumberGenerator_Tests: XCTestCase {
    // MARK: Parameters
    let sut = SystemRandomNumberGenerator()
    
    // MARK: TestCases
    func test_erasedToAnyRNG_returnsTypeErasedObject() {
        let anyRNG = sut.erasedToAnyRNG()
        
        XCTAssertTrue(anyRNG is AnyRandomNumberGenerator)
    }
    
    func test_run_performsOperationWithTypeErasure() {
        var copy = sut
        let closure: (inout AnyRandomNumberGenerator) -> Int = { rng in
            5
        }
        
        XCTAssertEqual(copy.run(closure), 5)
    }
}
