//
//  Collection+Utilities.swift
//  
//
//  Created by Martônio Júnior on 18/02/24.
//

public import Gen

public extension Collection where Self: Sendable {
    /// Generator that can return any element of this collection
    var elementGenerator: Gen<Element> {
        Gen.element(of: self).compactMap(\.self)
    }
}

public extension Collection where Self.Indices: Sendable {
    /// Generator that can return any index of this collection
    var indexGenerator: Gen<Index> {
        Gen.element(of: indices).compactMap(\.self)
    }
}
