//
//  Gen+Tests.swift
//
//
//  Created by Martônio Júnior on 21/03/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct GenTests {
    @Test("Returns same value as run()", arguments: [
        Gen<Int>.always(100)
    ])
    func callAsFunction(gen: Gen<Int>) async throws {
        #expect(gen.run() == gen())
    }
    
    @Test("Returns same value as run(&using)", arguments: [
        (Gen<Int>.always(64), SystemRandomNumberGenerator())
    ])
    func callAsFunction(gen: Gen<Int>, rng: SystemRandomNumberGenerator) async throws {
        var rng = rng
        #expect(gen.run(using: &rng) == gen(using: &rng))
    }
    
    @Test("Creates Generator with closure", arguments: [
        (4)
    ])
    func f(value: Int) async throws {
        let generator: Gen<Int> = .f { value }
        #expect(generator.run() == value)
    }
    
    @Suite("Global Methods")
    struct Global {
        @Test("Creates Generator By Combining Generators", arguments: [
            (Gen<Double>.always(10), Gen<String>.always("s"), (10, "s"))
        ])
        func zipAll(a: Gen<Double>, b: Gen<String>, _ outcome: (Double, String)) async throws {
            let zippedGenerator = SwiftChance.zipAll(a, b)
            
            let tuple = zippedGenerator.run()
            
            #expect(tuple == outcome)
        }
    }
    
    @Suite("RandomNumberGenerator conformance")
    struct RandomNumberGenerator {
        @Test("Allows Generator to work as RNG source", arguments: [
            (Gen<UInt64>.always(60), UInt64(60))
        ])
        func next(gen: Gen<UInt64>, outcome: UInt64) async throws {
            var gen = gen
            #expect(gen.next() == outcome)
        }
    }
}
