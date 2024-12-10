//
//  Randomizable+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct RandomizableTests {
    struct Mock: Randomizable {
        var value: Int
        
        mutating func randomize(input: Int) {
            value = input + value
        }
    }
    
    @Test("Configures Object based on Generator", arguments: [
        (Mock(value: 25), Gen<Mock.Input>.always(4), 29)
    ])
    func randomize(stub: Mock, generator: Gen<Mock.Input>, outcome: Mock.Input) async throws {
        var stub = stub
        stub.randomize(using: generator)
        #expect(stub.value == outcome)
    }
}
