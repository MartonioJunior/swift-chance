//
//  Dice.swift
//
//
//  Created by Martônio Júnior on 12/10/23.
//

import Foundation
import Gen

public typealias Dice = [Int]

// MARK: DotSyntax
public extension Dice {
    static func d(_ sides: Int) -> Dice {
        Dice(1...sides)
    }
}

public extension Gen where Value == [Int] {
    static func roll(_ amount: Gen<Int> = .always(1), dice: Dice) -> Gen<[Int]> {
        dice.elementGenerator.array(of: amount)
    }
    
    static func roll(_ amount: Gen<Int> = .always(1), d sides: Int) -> Gen<[Int]> {
        roll(amount, dice: .d(sides))
    }
}
