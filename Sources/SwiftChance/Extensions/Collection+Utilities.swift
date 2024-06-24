//
//  Collection+Utilities.swift
//  
//
//  Created by Martônio Júnior on 18/02/24.
//

public import Gen

public extension Collection {
    /// Generator that can return any element of this collection
    var elementGenerator: Gen<Element> {
        Gen.element(of: self).compactMap({ $0 })
    }
    
    /// Generator that can return any index of this collection
    var indexGenerator: Gen<Index> {
        Gen.element(of: indices).compactMap({ $0 })
    }
}
