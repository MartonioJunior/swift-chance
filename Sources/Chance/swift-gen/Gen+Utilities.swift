//
//  Gen+Utilities.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Gen {
    // MARK: Methods
    func callAsFunction() -> Value { run() }
    
    func callAsFunction<G: RandomNumberGenerator>(using generator: inout G) -> Value {
        run(using: &generator)
    }
    
    // MARK: Static Methods
    static func f(_ closure: @escaping () -> Value) -> Gen<Value> {
        .init { _ in closure() }
    }
}

// MARK: Global Methods
@inlinable
public func zip<each T>(_ generators: repeat Gen<each T>) -> Gen<(repeat each T)> {
    .init {
        (repeat (each generators)(using: &$0))
    }
}

// MARK: RandomNumberGenerator
extension Gen: RandomNumberGenerator where Value == UInt64 {
    mutating public func next() -> UInt64 { run() }
}
