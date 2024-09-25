//
//  Dice+Tests.swift
//
//
//  Created by Martônio Júnior on 06/11/23.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct DiceTests {
    @Test("Creates Dice from One to N", arguments: [
        (4, [1,2,3,4])
    ])
    func d(sides: Int, outcome: [Int]) async throws {
        let dice: Dice = .d(sides)
        #expect(dice == outcome)
    }
    
    @Test("Creates Gen simulating Dice", arguments: [
        (Gen<Int>.always(50), 7)
    ])
    func roll(generator: Gen<Int>, d: Int) async throws {
        let generator: Gen<[Int]> = .roll(generator, d: d)
        #expect(generator.run().reduce(true) { $0 && (1...d).contains($1) })
    }
    
    @Test("Creates Gen for Dice", arguments: [
        (Gen<Int>.always(50), [2,3,4,5,7])
    ])
    func roll(generator: Gen<Int>, dice: Dice) async throws {
        let generator: Gen<[Int]> = .roll(generator, dice: dice)
        #expect(generator.run().reduce(true) { $0 && dice.contains($1) })
    }
}
