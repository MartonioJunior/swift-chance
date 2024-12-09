//
//  Collection+Tests.swift
//  
//
//  Created by Martônio Júnior on 20/02/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct CollectionTests {
    @Test("Creates Generator for Elements", arguments: [
        ([1,2,3,4,5])
    ])
    func elementGenerator(collection: [Int]) async throws {
        let generator = collection.elementGenerator
        
        #expect(generator.array(of: .always(500)).run().allSatisfy(collection.contains))
    }
    
    @Test("Creates Generator for Indices", arguments: [
        ([1,2,3,4,5])
    ])
    func indexGenerator(collection: [Int]) async throws {
        let generator = collection.indexGenerator
        let indices = collection.indices
        
        #expect(generator.array(of: .always(500)).run().allSatisfy(indices.contains))
    }
}
