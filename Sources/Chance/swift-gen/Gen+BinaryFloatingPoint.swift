//
//  BinaryFloatingPoint+Random.swift
//
//
//  Created by Martônio Júnior on 24/10/23.
//

import Foundation
import Gen

extension Gen where Value: BinaryFloatingPoint, Value.RawSignificand: FixedWidthInteger {
    static var binaryFloatingPoint: Gen {
        .init {
            .random(in: -1_000_000_000...1_000_000_000, using: &$0)
        }
    }
    
    static var normalBinaryFloatingPoint: Gen {
        .init {
            .random(in: 0...1, using: &$0)
        }
    }

    static var signedBinaryFloatingPoint: Gen {
        .init {
            .random(in: -1...1, using: &$0)
        }
    }
}

extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    static func random() -> Self {
        Gen<Self>.binaryFloatingPoint.run()
    }
}
