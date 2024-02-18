//
//  Dice+Tests.swift
//
//
//  Created by Martônio Júnior on 06/11/23.
//

import XCTest
import Gen
@testable import Chance

final class Dice_Tests: XCTestCase {
    // MARK: Parameters
    let sut: Dice = [2,4,5,8,9]
    
    // MARK: Test Cases
    func test_d_createsDiceFromOneToN() {
        let value = Int.random(in: 1...30)
        let dice: Dice = .d(value)

        for i in 1...value {
            XCTAssertTrue(dice.contains(i))
        }
    }
    
    func test_roll_dice_createsGeneratorForDice() {
        let generator: Gen<[Int]> = .roll(.always(500), dice: sut)

        XCTAssertTrue(generator.run().reduce(true, {
            $0 && (sut.contains($1))
        }))
    }
    
    func test_roll_d_createsGeneratorSimulatingDice() {
        let generator: Gen<[Int]> = .roll(.always(500), d: 7)

        XCTAssertTrue(generator.run().reduce(true, {
            $0 && ((1...7).contains($1))
        }))
    }
}
