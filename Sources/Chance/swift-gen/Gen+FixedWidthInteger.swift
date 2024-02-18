//
//  Gen+FixedWidthInteger.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Gen where Value: FixedWidthInteger {
    static var fixedWidthInteger: Gen {
        .init {
            .random(in: .min ... .max, using: &$0)
        }
    }
}

public extension FixedWidthInteger {
    static func random() -> Self {
        Gen<Self>.fixedWidthInteger.run()
    }
}
