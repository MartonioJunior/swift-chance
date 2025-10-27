//
//  Gen+FixedWidthInteger.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Gen where Value: FixedWidthInteger & Sendable {
    /// Creates a new generator for fixed-width integers
    static var fixedWidthInteger: Gen {
        .init {
            .random(in: .min ... .max, using: &$0)
        }
    }
}

public extension FixedWidthInteger where Self: Sendable {
    /// Generates a new integer value
    /// - Returns: A new integer value
    static func random() -> Self {
        Gen<Self>.fixedWidthInteger.run()
    }
}
