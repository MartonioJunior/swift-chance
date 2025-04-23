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
    @Test("Instances Dice with the following sides", arguments: [
        ([1], [1]),
        ([1, 2], [1, 2]),
        ([1, 2, 3], [1, 2, 3]),
        ([1, 2, 3, 4], [1, 2, 3, 4]),
        ([1, 2, 3, 4, 5], [1, 2, 3, 4, 5]),
        ([1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6])
    ])
    func `init`(sides: [Int], outcome: [Int]) async throws {
        let dice: Dice = .init(sides)
        #expect(dice.sides == outcome)
    }

    @Test("Creates a generator for rolls", arguments: [
        (Dice.d(6), Gen<Int>.always(50))
    ])
    func rollGenerator(_ dice: Dice, generator: Gen<Int>) async throws {
        let rollGenerator: Gen<Int> = dice.rollGenerator
        #expect(rollGenerator.array(of: generator).run().reduce(true) { $0 && dice.contains($1) })
    }

    @Test("Creates Dice from One to N", arguments: [
        (4, Dice([1, 2, 3, 4])),
        (0, Dice([]))
    ])
    func d(sides: Int, outcome: Dice) async throws {
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
        (Gen<Int>.always(50), Dice([2, 3, 4, 5, 7]))
    ])
    func roll(generator: Gen<Int>, dice: Dice) async throws {
        let generator: Gen<[Int]> = .roll(generator, dice)
        #expect(generator.run().reduce(true) { $0 && dice.contains($1) })
    }
}
