//
//  Randomizable.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

public import Gen

/// Protocol for describing how the type should be configured based on an input
public protocol Randomizable {
    associatedtype Input

    /// Mutates the value based on the specified input
    /// - Parameters:
    ///     - input: The input parameter of configuration
    mutating func randomize(input: Input)
}

// MARK: Default Implementation
public extension Randomizable {
    /// Mutates the object based on the input created by a generator
    /// - Parameters:
    ///     - generator: Generator used to give the input
    mutating func randomize(using generator: Gen<Input>) {
        randomize(input: generator.run())
    }
}
