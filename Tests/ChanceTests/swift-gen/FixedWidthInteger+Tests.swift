//
//  Gen+Tests.cs.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
import Gen
@testable import Chance

final class FixedWidthInteger_Tests: XCTestCase {
    // MARK: Test Utilities
    func testGenerator(_ range: ClosedRange<Int> = Int.min...Int.max) -> (Gen<Int>) -> Bool {
        {
            $0.array(of: .always(100)).run().allSatisfy((Int.min...Int.max).contains)
        }
    }
    
    // MARK: Test Cases
    func test_fixedWidthInteger_returnsValueInRepresentableRange()
    {
        let generator: Gen<Int> = .fixedWidthInteger

        XCTAssert(testGenerator()(generator))
    }
    
    func test_random_returnsValueInRepresentableRange()
    {
        let generator: Gen<Int> = .f { .random() }
        
        XCTAssert(testGenerator()(generator))
    }
}
