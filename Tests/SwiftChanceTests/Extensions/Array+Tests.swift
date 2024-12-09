//
//  Array+Tests.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

import Testing
@preconcurrency import Gen
@testable import SwiftChance

struct ArrayTests {
    @Test("Removes Many Elements At Random", arguments: [
        ([1,2,3,5], 1, 1),
        ([4,5,2,1,9,6], 3, 3),
        ([2,3], 4, 2),
        ([], 1, 0)
    ])
    func removeRandom(array: [Int], count: Int, expectedRemoval: Int) async throws {
        var copy = array
        let value = copy.removeRandom(count: .always(count))

        #expect(value.allSatisfy(array.contains(_:)))
        #expect(value.allSatisfy({ !copy.contains($0) }))
        #expect(array.count - copy.count == expectedRemoval)
    }
    
    @Test("Removes Elements at Random with Index Generator", arguments: [
        ([1,2,3,5], 1, 0, [1]),
        ([3,5,6,7], 2, 1, [5,6]),
        ([34,56], 5, 0, [34,56]),
        ([22,44], 1, 2, []),
        ([3,7], 0, 0, []),
        ([], 1, 0, [])
    ])
    func removeRandom(array: [Int], count: Int, index: Int, outcome: [Int]) async throws {
        var copy = array
        let value = copy.removeRandom(count: .always(count), indexGenerator: .always(index))
        
        #expect(value == outcome)
        #expect(array.contains(value))
        #expect(value.allSatisfy({ !copy.contains($0) }))
    }
}
