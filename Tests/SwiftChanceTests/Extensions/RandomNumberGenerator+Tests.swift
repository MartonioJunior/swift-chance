//
//  RandomNumberGenerator+Tests.swift
//  
//
//  Created by Martônio Júnior on 20/02/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct RandomNumberGeneratorTests {
    @Test("Returns Type-Erased Object", arguments: [
        SeedRNG(.seed1D(1))
    ])
    func erasedToAnyRNG(rng: SeedRNG) async throws {
        var rngCopy = rng
        var anyRNG = rng.erasedToAnyRNG()
        
        #expect(rngCopy.next() == anyRNG.next())
    }
    
    @Test("Performs Operation with Type Erasure", arguments: [
        (SeedRNG(.seed1D(1)), 5)
    ])
    func run(rng: SeedRNG, outcome: Int) async throws {
        var rngCopy = rng
        let closure: (inout AnyRandomNumberGenerator) -> Int = { rng in outcome }
        
        #expect(rngCopy.run(closure) == outcome)
    }
}
