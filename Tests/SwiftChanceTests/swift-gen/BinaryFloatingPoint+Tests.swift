//
//  BinaryFloatingPoint+Tests.swift
//
//
//  Created by Martônio Júnior on 27/11/23.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct BinaryFloatingPointTests {
    @Test("Returns value inside valid Range", arguments: [
        (Gen<Double>.binaryFloatingPoint, -1_000_000_000...1_000_000_000),
        (Gen<Double>.normalBinaryFloatingPoint, 0...1),
        (Gen<Double>.signedBinaryFloatingPoint, -1...1)
    ])
    func evaluateGenerators(gen: Gen<Double>, range: ClosedRange<Double>) async throws {
        #expect(gen.array(of: .always(100)).run().allSatisfy(range.contains))
    }
    
    @Test("Returns valid Binary Floating Point value")
    func random() async throws {
        let gen: Gen<Double> = .f(Double.random)
        let range: ClosedRange<Double> = -1_000_000_000...1_000_000_000
        #expect(gen.array(of: .always(100)).run().allSatisfy(range.contains))
    }
}
