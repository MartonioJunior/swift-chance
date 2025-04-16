//
//  Dice.swift
//
//
//  Created by Martônio Júnior on 12/10/23.
//

import Foundation
import Gen

/// Represents a set of possible outcomes with equal weight
public typealias Dice = [Int]

// MARK: DotSyntax
public extension Dice {
    /// SwiftChance: Creates a new dice with the specified number of sides
    ///
    /// - Parameters:
    ///     - sides: Number of sides in the dice
    /// - Returns: A new `Dice` from 1 ... `sides`
    static func d(_ sides: Int) -> Dice {
        Dice(1...sides)
    }
}

public extension Gen where Value == [Int] {
    /// SwiftChance: Creates a new generator that simulates a dice roll
    ///
    /// - Parameters:
    ///   - amount: Number of times the dice will be rolled
    ///   - dice: Dice used by the generator
    /// - Returns: An array with the dice roll outcomes
    static func roll(_ amount: Gen<Int> = .always(1), dice: Dice) -> Gen<[Int]> {
        dice.elementGenerator.array(of: amount)
    }

    /// SwiftChance: Creates a new generator that simulates a dice roll
    ///
    /// - Parameters:
    ///   - amount: Number of times the dice will be rolled
    ///   - sides: Number of sides the dice has
    /// - Returns: An array with the dice roll outcomes
    static func roll(_ amount: Gen<Int> = .always(1), d sides: Int) -> Gen<[Int]> {
        roll(amount, dice: .d(sides))
    }
}
