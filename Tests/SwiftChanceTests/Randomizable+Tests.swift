//
//  Randomizable+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
@testable import Chance

// MARK: Stub
extension Randomizable_Tests {
    struct Stub: Randomizable {
        var value: Int
        
        mutating func randomize(input: Int) {
            value = input
        }
    }
}

final class Randomizable_Tests: XCTestCase {
    // MARK: Test Methods
    func test_randomize_configuresObjectBasedOnGenerator() {
        var stub = Stub(value: 25)
        
        stub.randomize(using: .always(4))
        
        XCTAssertEqual(stub.value, 4)
    }
}
