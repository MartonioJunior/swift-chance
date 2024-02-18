//
//  Gen+UnicodeScalar.swift
//
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Gen where Value == UnicodeScalar {
    static var unicodeScalar: Gen {
        Gen<UInt8>.fixedWidthInteger.map(UnicodeScalar.init)
    }
}
