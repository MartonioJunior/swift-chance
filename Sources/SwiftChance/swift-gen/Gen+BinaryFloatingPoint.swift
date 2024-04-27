//
//  BinaryFloatingPoint+Random.swift
//
//
//  Created by Martônio Júnior on 24/10/23.
//

import Foundation
import Gen

public extension Gen where Value: BinaryFloatingPoint, Value.RawSignificand: FixedWidthInteger {
    /// Creates a new generator for binary floating numbers between `-1_000_000_000...1_000_000_000`
    static var binaryFloatingPoint: Gen {
        .init {
            .random(in: -1_000_000_000...1_000_000_000, using: &$0)
        }
    }
    
    /// Creates a new generator for binary floating numbers between `0...1`
    static var normalBinaryFloatingPoint: Gen {
        .init {
            .random(in: 0...1, using: &$0)
        }
    }

    /// Creates a new generator for binary floating numbers between `-1...1`
    static var signedBinaryFloatingPoint: Gen {
        .init {
            .random(in: -1...1, using: &$0)
        }
    }
}

public extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    /// Generates a new binary floating-point number
    /// - Returns: A new floating-point number
    static func random() -> Self {
        Gen<Self>.binaryFloatingPoint.run()
    }
}
