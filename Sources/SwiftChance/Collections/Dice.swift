//
//  Dice.swift
//
//
//  Created by Martônio Júnior on 12/10/23.
//

import Foundation
public import Gen

/// Represents a set of possible outcomes with equal weight
public struct Dice {
    // MARK: Variables
    var sides: [Int]

    // MARK: Initializers
    public init(_ sides: some Sequence<Int>) {
        self.sides = Array(sides)
    }
}

// MARK: DotSyntax
public extension Dice {
    /// SwiftChance: Create a generator that simulates a dice roll
    /// 
    /// - Returns: A generator that simulates a dice roll
    var rollGenerator: Gen<Int> { sides.elementGenerator }
    /// SwiftChance: Creates a new dice with the specified number of sides
    ///
    /// - Parameters:
    ///     - sides: Number of sides in the dice
    /// - Returns: A new `Dice` from 1 ... `sides`
    static func d(_ sides: Int) -> Dice {
        guard sides > 0 else { return Dice([]) }

        return Dice(1...sides)
    }
}

// MARK: Self: Collection
extension Dice: Collection {
    public typealias Index = Int
    public typealias Element = Int

    public var startIndex: Index { sides.startIndex }
    public var endIndex: Index { sides.endIndex }

    public subscript(position: Index) -> Element { sides[position] }
    public func index(after i: Index) -> Index { sides.index(after: i) }
}

// MARK: Self: Equatable
extension Dice: Equatable {}

// MARK: Self: ExpressibleByArrayLiteral
extension Dice: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Int

    public init(arrayLiteral elements: Int...) {
        self.init(elements)
    }
}

// MARK: Self: Sendable
extension Dice: Sendable {}

// MARK: Gen (EX)
public extension Gen where Value == [Int] {
    /// SwiftChance: Creates a new generator that simulates a dice roll
    ///
    /// - Parameters:
    ///   - amount: Number of times the dice will be rolled
    ///   - dice: Dice used by the generator
    /// - Returns: An array with the dice roll outcomes
    static func roll(_ amount: Gen<Int> = .always(1), _ dice: Dice) -> Gen<[Int]> {
        dice.rollGenerator.array(of: amount)
    }

    /// SwiftChance: Creates a new generator that simulates a dice roll
    ///
    /// - Parameters:
    ///   - amount: Number of times the dice will be rolled
    ///   - sides: Number of sides the dice has
    /// - Returns: An array with the dice roll outcomes
    static func roll(_ amount: Gen<Int> = .always(1), d sides: Int) -> Gen<[Int]> {
        roll(amount, .d(sides))
    }
}
