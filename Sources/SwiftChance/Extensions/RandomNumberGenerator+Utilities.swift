//
//  RandomNumberGenerator+Utilities.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

public import Gen

public extension RandomNumberGenerator {
    /// SwiftChance: Erases the type to `AnyRandomNumberGenerator`
    /// - Returns: A new `AnyRandomNumberGenerator` instance
    func erasedToAnyRNG() -> AnyRandomNumberGenerator { .init(self) }
    
    /// SwiftChance: Returns a new value originated from a closure receiving a type-erased version of `RandomNumberGenerator`
    /// - Parameters:
    ///     - closure: Operation to be performed by the type-erased `RandomNumberGenerator`
    /// - Returns: A random value of `T` from the closure's output
    mutating func run<T>(_ closure: (inout AnyRandomNumberGenerator) -> T) -> T {
        var arng = erasedToAnyRNG()
        return closure(&arng)
    }
}
