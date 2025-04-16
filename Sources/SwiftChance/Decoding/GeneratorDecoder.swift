//
//  RandomDecoder.swift
//
//
//  Created by Martônio Júnior on 29/10/23.
//

import Foundation
@preconcurrency import Gen

/// Special decoder based on Gen that generates any type in a controllable manner
/// by using a custom data generator (`Gen<UInt64>`)
///
/// Can be used as a way of creating random test cases of any type
public struct GeneratorDecoder: Decoder {
    // MARK: Decoder
    /// Base generator used for creating all values during the decoding process
    ///
    /// `GeneratorDecoder` uses `UInt64` type as the data source for creating more
    /// complex data types inside of the application, passing it
    /// to `KeyedContainer`, `SingleValueContainer` and `UnkeyedContainer`
    var dataGenerator: Gen<UInt64>
    public var codingPath: [any CodingKey] = []
    public var userInfo: [CodingUserInfoKey: Any] = [:]

    public func container<Key: CodingKey>(
        keyedBy type: Key.Type
    ) throws -> KeyedDecodingContainer<Key> {
        .init(KeyedContainer(dataGenerator: dataGenerator))
    }

    public func unkeyedContainer() throws -> any UnkeyedDecodingContainer {
        UnkeyedContainer(dataGenerator: dataGenerator)
    }

    public func singleValueContainer() throws -> any SingleValueDecodingContainer {
        SingleValueContainer(dataGenerator: dataGenerator)
    }
}

// MARK: KeyedContainer
extension GeneratorDecoder {
    /// Keyed Container for `GeneratorDecoder`
    struct KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
        /// Generator used for creating all values in this container during the decode process
        var dataGenerator: Gen<UInt64>
        public var codingPath: [any CodingKey] = []
        public var allKeys: [Key] = []

        public func contains(_ key: Key) -> Bool { return true }

        public func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
            try .init(from: GeneratorDecoder(dataGenerator: dataGenerator))
        }

        public func decodeNil(forKey key: Key) throws -> Bool {
            .init(truncating: .init(value: dataGenerator.run()))
        }

        public func nestedContainer<NestedKey: CodingKey>(
            keyedBy type: NestedKey.Type, forKey key: Key
        ) throws -> KeyedDecodingContainer<NestedKey> {
            .init(KeyedContainer<NestedKey>(dataGenerator: dataGenerator))
        }

        public func nestedUnkeyedContainer(
            forKey key: Key
        ) throws -> any UnkeyedDecodingContainer {
            UnkeyedContainer(dataGenerator: dataGenerator)
        }

        public func superDecoder() throws -> any Decoder {
            GeneratorDecoder(dataGenerator: dataGenerator)
        }

        public func superDecoder(forKey key: Key) throws -> any Decoder {
            GeneratorDecoder(dataGenerator: dataGenerator)
        }
    }
}

// MARK: SingleValueContainer
extension GeneratorDecoder {
    /// Single Value Container for `GeneratorDecoder`
    struct SingleValueContainer: SingleValueDecodingContainer {
        /// Generator used for creating all values in this container during the decode process
        var dataGenerator: Gen<UInt64>

        var codingPath: [any CodingKey] = []

        func decodeNil() -> Bool {
            .init(truncating: .init(value: dataGenerator.run()))
        }

        func decode(_ type: Bool.Type) throws -> Bool {
            .init(truncating: .init(value: dataGenerator.run()))
        }

        func decode(_ type: String.Type) throws -> String {
            .init(dataGenerator.run())
        }

        func decode(_ type: Double.Type) throws -> Double {
            .init(dataGenerator.run())
        }

        func decode(_ type: Float.Type) throws -> Float {
            .init(dataGenerator.run())
        }

        func decode(_ type: Int.Type) throws -> Int {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: Int8.Type) throws -> Int8 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: Int16.Type) throws -> Int16 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: Int32.Type) throws -> Int32 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: Int64.Type) throws -> Int64 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: UInt.Type) throws -> UInt {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: UInt8.Type) throws -> UInt8 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: UInt16.Type) throws -> UInt16 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: UInt32.Type) throws -> UInt32 {
            .init(truncatingIfNeeded: dataGenerator.run())
        }

        func decode(_ type: UInt64.Type) throws -> UInt64 {
            dataGenerator.run()
        }

        func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
            try T(from: GeneratorDecoder(dataGenerator: dataGenerator))
        }
    }
}

// MARK: UnkeyedContainer
extension GeneratorDecoder {
    /// Unkeyed Container for `GeneratorDecoder`
    struct UnkeyedContainer: UnkeyedDecodingContainer {
        var dataGenerator: Gen<UInt64>
        var codingPath: [any CodingKey] = []
        var count: Int? = 3
        var isAtEnd: Bool { currentIndex == count }
        private(set) var currentIndex: Int = 0

        mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
            defer { currentIndex += 1 }
            return try .init(from: GeneratorDecoder(dataGenerator: dataGenerator))
        }

        mutating func decodeNil() throws -> Bool {
            defer { currentIndex += 1 }
            return .init(truncating: .init(value: dataGenerator.run()))
        }

        mutating func nestedContainer<NestedKey>(
            keyedBy type: NestedKey.Type
        ) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
            .init(KeyedContainer<NestedKey>(dataGenerator: dataGenerator))
        }

        mutating func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
            UnkeyedContainer(dataGenerator: dataGenerator)
        }

        mutating func superDecoder() throws -> any Decoder {
            GeneratorDecoder(dataGenerator: dataGenerator)
        }
    }
}

// MARK: Sendable
extension GeneratorDecoder: @unchecked Sendable {}
