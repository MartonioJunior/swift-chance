//
//  Bool+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct BoolTests {
    @Test("Returns Generator with odds of True", arguments: [
        (1, Gen<Double>.binaryFloatingPoint, true),
        (0, Gen<Double>.binaryFloatingPoint, false),
        (0.5, Gen<Double>.always(0.6), false),
        (0.5, Gen<Double>.always(0.4), true),
    ])
    func chance(odds: Double, gen: Gen<Double>, outcome: Bool) async throws {
        let generator: Gen<Bool> = .chance(odds, generator: gen)
        #expect(generator.run() == outcome)
    }
}
