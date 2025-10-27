//
//  Gen+Utilities.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

public import Gen

public extension Gen {
    // MARK: Methods
    /// Returns a random value
    /// - Returns: A random value
    func callAsFunction() -> Value { run() }

    /// Returns a random value
    /// - Parameters:
    ///     - generator: A random number generator
    /// - Returns: A random value
    func callAsFunction<G: RandomNumberGenerator>(using generator: inout G) -> Value {
        run(using: &generator)
    }

    // MARK: Static Methods
    /// Creates a new generator based on a function that isn't influenced by the `RandomNumberGenerator`
    ///
    /// - Parameters:
    ///  closure: the function that returns a value
    /// - Returns: A generator that returns `Value`
    static func f(_ closure: @escaping @Sendable () -> Value) -> Gen<Value> {
        .init { _ in closure() }
    }
}

// MARK: Global Methods
@inlinable
/// Parameter-Pack version of `Gen.zip()`, allowing any number of generators of varied types
/// - Parameters:
///     - generators: set of generators to be combined
/// - Returns: A new generator with the combined output as a tuple
public func zipAll<each T>(_ generators: repeat Gen<each T>) -> Gen<(repeat each T)> {
    .init {
        (repeat (each generators)(using: &$0))
    }
}

// MARK: RandomNumberGenerator
extension Gen: @retroactive RandomNumberGenerator where Value == UInt64 {
    mutating public func next() -> UInt64 { run() }
}
