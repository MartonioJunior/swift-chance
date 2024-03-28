//
//  Collection+Utilities.swift
//  
//
//  Created by Martônio Júnior on 18/02/24.
//

import Foundation
import Gen

public extension Collection {
    var elementGenerator: Gen<Element> {
        Gen.element(of: self).compactMap({ $0 })
    }
    
    var indexGenerator: Gen<Index> {
        Gen.element(of: indices).compactMap({ $0 })
    }
}
