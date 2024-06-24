//
//  Array+Tests.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

import XCTest
import Gen

final class Array_Tests: XCTestCase {
    // MARK: Parameters
    var sut = [1,2,3,4]
    
    // MARK: Test Cases
    func test_removeRandom_removesManyElementsAtRandom() {
        var copy = sut
        let value = copy.removeRandom()
        
        XCTAssertTrue(sut.contains(value))
        XCTAssertFalse(copy.contains(value))
        XCTAssertEqual(copy.count, 3)
    }
    
    func test_removeRandom_removesElementsWithIndexGenerator() {
        var copy = sut
        let indexGenerator = Gen<Int>.always(0)
        let value = copy.removeRandom(indexGenerator: indexGenerator)
        
        XCTAssertTrue(sut.contains(value))
        XCTAssertFalse(copy.contains(value))
        XCTAssertEqual(copy, [2,3,4])
    }
    
    func test_removeRandom_returnsCollectionWhenAmountHigherThanCount() {
        _ = sut
        let result = sut.removeRandom(count: .always(5), indexGenerator: .always(0))
        
        XCTAssertTrue(result.allSatisfy((1...4).contains))
        XCTAssertEqual(0, sut.count)
    }
}
