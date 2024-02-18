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
    // MARK: Test Cases
    func test_random_returnsNewValue() {
        let value = Gen<Double>.binaryFloatingPoint.array(of: .always(100))

        XCTAssertTrue(value.run().allSatisfy((-1_000_000_000...1_000_000_000).contains))
    }
    
    func test_randomNormal_returnsValueBetweenZeroAndOne() {
        let value = Gen<Double>.normalBinaryFloatingPoint.array(of: .always(100))

        XCTAssertTrue(value.run().allSatisfy((0...1).contains))
    }
    
    func test_randomSigned_returnsValueBetweenPositiveAndMinusOne() {
        let value = Gen<Double>.normalBinaryFloatingPoint.array(of: .always(100))

        XCTAssertTrue(value.run().allSatisfy((-1...1).contains))
    }
}
