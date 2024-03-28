//
//  Collection+Tests.swift
//  
//
//  Created by Martônio Júnior on 20/02/24.
//

import XCTest

final class Collection_Tests: XCTestCase {
    // MARK: Parameters
    let sut = [1,2,3,4,5]
    
    // MARK: Test Cases
    func test_elementGenerator_createsGeneratorForElements() {
        let generator = sut.elementGenerator
        
        let result = generator.array(of: .always(500)).run().reduce(true) {
            $0 && sut.contains($1)
        }

        XCTAssertTrue(result)
    }
    
    func test_indexGenerator_createsGeneratorForIndices() {
        let generator = sut.indexGenerator
        
        let result = generator.array(of: .always(500)).run().reduce(true) {
            $0 && sut.indices.contains($1)
        }

        XCTAssertTrue(result)
    }
}
