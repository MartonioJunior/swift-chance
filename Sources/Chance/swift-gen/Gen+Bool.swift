//
//  Gen+Bool.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Gen {
    static func chance(_ oddsOfTrue: Double) -> Gen<Bool> {
        Gen<Double>.normalBinaryFloatingPoint.map { $0 <= oddsOfTrue }
    }
}
