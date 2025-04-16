//
//  Gen+Bool.swift
//  
//
//  Created by Martônio Júnior on 10/02/24.
//

public import Gen

public extension Gen {
    /// Creates a new boolean generator that determines the outcome based on the odds of being true
    /// - Parameters:
    ///   - oddsOfTrue: Normalized odds of it being true.
    ///   - generator: Generator used to generate the value for the comparison
    /// - Returns:
    ///     `true` when `oddsOfTrue >= 1` or the odds are above or equal generated value.
    ///     `false` when `oddsOfTrue <= 0` or the odds are below the generated value.
    static func chance<T>(
        _ oddsOfTrue: T,
        generator: Gen<T> = .normalBinaryFloatingPoint
    ) -> Gen<Bool> where T: BinaryFloatingPoint, T.RawSignificand: FixedWidthInteger {
        if oddsOfTrue >= 1 {
            .always(true)
        } else if oddsOfTrue <= 0 {
            .always(false)
        } else {
            generator.map { $0 <= oddsOfTrue }
        }
    }
}
