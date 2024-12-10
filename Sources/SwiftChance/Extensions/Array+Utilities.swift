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
        guard !isEmpty else { return [] }

        return removeRandom(count: count, indexGenerator: indexGenerator)
    }
    
    /// SwiftChance: Removes multiple elements at random using an index generator
    /// - Parameters:
    ///   - count: amount of elemens to be removed
    ///   - indexGenerator: generator responsible for determining which element should be removed
    /// - Returns: an array with all removed elements
    mutating func removeRandom(count: Gen<Int> = .always(1), indexGenerator: Gen<Index>) -> [Element] {
        return indexGenerator.array(of: count).run().compactMap {
            let index = $0 % (indices.upperBound + 1)

            guard indices.contains(index) else { return nil }

            return remove(at: index)
        }
    }
}
