//
//  BinaryFloatingPoint+Tests.swift
//
//
//  Created by Martônio Júnior on 27/11/23.
//

import XCTest
import Gen
@testable import Chance

final class BinaryFloatingPoint_Tests: XCTestCase {
    typealias RNG = SystemRandomNumberGenerator
    // MARK: Utilities
    public func testGenerator(range: ClosedRange<Double> = -1_000_000_000...1_000_000_000) -> (Gen<Double>) -> Bool {
        {
            $0.array(of: .always(100)).run().allSatisfy((range).contains)
        }
    }
    
    // MARK: Test Cases
    func test_binaryFloatingPoint_returnsValueInsideValidRange() {
        let generator: Gen<Double> = .binaryFloatingPoint
        
        XCTAssertTrue(testGenerator()(generator))
    }
    
    func test_normalBinaryFloatingPoint_returnsValueBetweenZeroAndOne() {
        let generator: Gen<Double> = .normalBinaryFloatingPoint

        XCTAssertTrue(testGenerator(range: 0...1)(generator))
    }
    
    func test_signedBinaryFloatingPoint_returnsValueBetweenPositiveAndMinusOne() {
        let generator: Gen<Double> = .signedBinaryFloatingPoint

        XCTAssertTrue(testGenerator(range: -1...1)(generator))
    }
    
    func test_random_returnsNewValue() {
        let value: Gen<Double> = .f { .random() }
        
        XCTAssertTrue(testGenerator()(value))
    }
}
