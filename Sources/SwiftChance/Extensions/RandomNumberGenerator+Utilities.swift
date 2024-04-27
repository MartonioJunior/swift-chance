//
//  RandomNumberGenerator+Utilities.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension RandomNumberGenerator {
    func erasedToAnyRNG() -> AnyRandomNumberGenerator { .init(self) }

    mutating func run<T>(_ closure: (inout AnyRandomNumberGenerator) -> T) -> T {
        var arng = erasedToAnyRNG()
        return closure(&arng)
    }
}
