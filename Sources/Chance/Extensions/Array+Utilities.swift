//
//  Collection+Utilities.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

import Foundation
import Gen

public extension Array {
    mutating func removeRandom(count: Gen<Int> = .always(1)) -> [Element] {
        removeRandom(count: count, indexGenerator: indexGenerator)
    }

    mutating func removeRandom(count: Gen<Int> = .always(1), indexGenerator: Gen<Index>) -> [Element] {
        return indexGenerator.array(of: .always(count.run())).run().map {
            remove(at: $0)
        }
    }
}
