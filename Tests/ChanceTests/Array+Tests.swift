//
//  Array+Tests.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

import XCTest

final class Array_Tests: XCTestCase {
    // MARK: Test Cases
    func test_randomIndex_returnsIndexInCollection() {
        let array = [1,2,3,4]
        let generator = array.indexGenerator.array(of: .always(100))
        
        XCTAssertTrue(generator.run().allSatisfy((0...3).contains))
    }
    
    func test_randomPop_removesElementFromCollection() {
        var array = [1,2,3,4]
        let result = array.removeRandom(count: .always(5), indexGenerator: .always(0))
        
        XCTAssertTrue(result.allSatisfy((1...4).contains))
        XCTAssertEqual(0, array.count)
    }
}
