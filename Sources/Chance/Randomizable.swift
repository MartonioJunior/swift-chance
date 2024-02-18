//
//  Randomizable.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public protocol Randomizable {
    associatedtype Input

    mutating func randomize(input: Input)
}

public extension Randomizable {
    mutating func randomize(using generator: Gen<Input>) {
        randomize(input: generator.run())
    }
}
