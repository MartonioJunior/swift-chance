//
//  Gen+Tests.cs.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct FixedWidthIntegerTests {
    @Test("Returns value in representable Range", arguments: [
        (Gen<Int>.fixedWidthInteger, Int.min...Int.max),
    ])
    func evaluateGenerators(gen: Gen<Int>, range: ClosedRange<Int>) async throws {
        #expect(gen.array(of: .always(100)).run().allSatisfy(range.contains))
    }
    
    @Test("Returns valid fixed-width Integer value")
    func random() async throws {
        let gen: Gen<Int> = .f { .random() }
        let range = Int.min...Int.max
        #expect(gen.array(of: .always(100)).run().allSatisfy(range.contains))
    }
}
