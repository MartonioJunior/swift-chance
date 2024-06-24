//
//  Gen+Tests.swift
//
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
import Gen
@testable import SwiftChance

final class Gen_Tests: XCTestCase {
    // MARK: Test Cases
    func test_callAsFunction_returnsSameValueAsRun() {
        let generator: Gen = .always(100)
        
        XCTAssertEqual(generator.run(), generator())
    }
    
    func test_callAsFunction_generator_returnsSameValueAsRun() {
        let generator: Gen = .always(100)
        var rng = SystemRandomNumberGenerator()
        
        XCTAssertEqual(generator.run(using: &rng), generator(using: &rng))
    }
    
    func test_f_createsGeneratorWithClosure() {
        let closure = { 4 }
        let generator: Gen<Int> = .f(closure)

        XCTAssertEqual(closure(), generator.run())
    }
    
    // MARK: Global Methods
    func test_zipAll_createsGeneratorByCombiningGenerators() {
        let generatorA: Gen<Double> = .always(10)
        let generatorB: Gen<String> = .always("s")
        
        let zippedGenerator = zipAll(generatorA, generatorB)
        
        let (number, text) = zippedGenerator.run()
        
        XCTAssertEqual(number, 10)
        XCTAssertEqual(text, "s")
    }
    
    // MARK: Gen: RandomNumberGenerator
    func test_next_allowsGeneratorToWorkAsRNGSource() {
        var generator: Gen<UInt64> = .always(60)
        
        XCTAssertEqual(generator.next(), 60)
    }
}
