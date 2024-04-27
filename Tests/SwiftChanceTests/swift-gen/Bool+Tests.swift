//
//  Bool+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
import Gen
@testable import SwiftChance

final class Bool_Tests: XCTestCase {
    func test_chance_returnsGeneratorWithOddsOfTrue()
    {
        let alwaysTrue: Gen<Bool> = .chance(1)
        let alwaysFalse: Gen<Bool> = .chance(0)
        
        let checkCondition: (Bool) -> (Gen<Bool>) -> Bool = { result in
            { generator in
                generator.array(of: .always(100)).run().allSatisfy { element in
                    element == result
                }
            }
        }
        
        XCTAssertTrue(checkCondition(true)(alwaysTrue))
        XCTAssertTrue(checkCondition(false)(alwaysFalse))
        
        let valueOverOdds: Gen<Bool> = .chance(0.5, generator: .f({ 0.6 }))
        let valueUnderOdds: Gen<Bool> = .chance(0.5, generator: .f({ 0.4 }))
        
        XCTAssertTrue(checkCondition(true)(valueUnderOdds))
        XCTAssertTrue(checkCondition(false)(valueOverOdds))
    }
}
