//
//  Gen+Bool.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Gen {
    static func chance<T>(_ oddsOfTrue: T, generator: Gen<T> = .normalBinaryFloatingPoint) -> Gen<Bool> where T: BinaryFloatingPoint, T.RawSignificand: FixedWidthInteger {
        if oddsOfTrue >= 1 {
            .always(true)
        } else if oddsOfTrue <= 0 {
            .always(false)
        } else {
            generator.map { $0 <= oddsOfTrue }
        }
    }
}
