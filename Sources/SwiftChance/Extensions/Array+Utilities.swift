//
//  Array+Utilities.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

public import Gen

public extension Array {
    /// SwiftChance: Removes multiples elements at random
    ///
    /// - Parameters:
    ///     - count: amount of elements to be removed
    /// - Returns: an array with all removed elements
    mutating func removeRandom(count: Gen<Int> = .always(1)) -> [Element] {
        removeRandom(count: count, indexGenerator: indexGenerator)
    }
    
    /// SwiftChance: Removes multiple elements at random using an index generator
    /// - Parameters:
    ///   - count: amount of elemens to be removed
    ///   - indexGenerator: generator responsible for determining which element should be removed
    /// - Returns: an array with all removed elements
    mutating func removeRandom(count: Gen<Int> = .always(1), indexGenerator: Gen<Index>) -> [Element] {
        return indexGenerator.array(of: .always(count.run())).run().compactMap {
            guard indices.contains($0) else { return nil }
            
            return remove(at: $0)
        }
    }
}
