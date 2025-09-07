//
//  Dice+Tests.swift
//
//
//  Created by Martônio Júnior on 06/11/23.
//

@preconcurrency import Gen
@testable import SwiftChance
import Testing

struct DiceTests {
    @Test("Instances Dice with the following sides", arguments: [
        ([1]),
        ([1, 2]),
        ([1, 2, 3]),
        ([1, 2, 3, 4]),
        ([1, 2, 3, 4, 5]),
        ([1, 2, 3, 4, 5, 6])
    ])
    func initializer(sides: [Int]) {
        let dice: Dice = .init(sides)
        #expect(dice.sides == sides)
    }

    @Test("Creates a generator for rolls", arguments: [
        (Dice.d(6), Gen<Int>.always(50))
    ])
    func rollGenerator(_ dice: Dice, generator: Gen<Int>) throws {
        let rollGenerator: Gen<Int> = dice.rollGenerator
        #expect(rollGenerator.array(of: generator).run().allSatisfy { dice.contains($0) })
    }

    @Test("Creates Dice from One to N", arguments: [
        (4, Dice([1, 2, 3, 4])),
        (0, Dice([]))
    ])
    func d(sides: Int, outcome: Dice) {
        let dice: Dice = .d(sides)
        #expect(dice == outcome)
    }

    @Test("Creates Gen simulating Dice", arguments: [
        (Gen<Int>.always(50), 7)
    ])
    func roll(generator: Gen<Int>, d: Int) {
        let generator: Gen<[Int]> = .roll(generator, d: d)
        #expect(generator.run().allSatisfy { (1...d).contains($0) })
    }

    @Test("Creates Gen for Dice", arguments: [
        (Gen<Int>.always(50), Dice([2, 3, 4, 5, 7]))
    ])
    func roll(generator: Gen<Int>, dice: Dice) {
        let generator: Gen<[Int]> = .roll(generator, dice)
        #expect(generator.run().allSatisfy { dice.contains($0) })
    }

    // MARK: Self: ExpressibleByArrayLiteral
    struct ConformsToExpressibleByArrayLiteral {
        @Test("Creates new dice with array of elements")
        func initializerArrayLiteral() {
            let result = Dice(arrayLiteral: 2, 3, 4, 9)
            let expected = Dice([2, 3, 4, 9])
            #expect(result == expected)
        }
    }
}
