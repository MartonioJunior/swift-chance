//
//  GeneratorDecoder+Tests.swift
//
//
//  Created by Martônio Júnior on 21/03/24.
//

import Foundation
@preconcurrency import Gen
@testable import SwiftChance
import Testing

// MARK: Stubs
struct StubKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init() {
        self.stringValue = ""
        self.intValue = 0
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = ""
    }
}

// MARK: GeneratorDecoder
struct GeneratorDecoderTests {
    @Test("Creates new Decoder", arguments: [
        (Gen<UInt64>.always(137))
    ])
    func initializer(_ gen: Gen<UInt64>) throws {
        let decoder: GeneratorDecoder = .init(dataGenerator: gen)
        #expect(decoder.dataGenerator() == 137)
    }

    @Test("Creates Keyed Container", arguments: [
        (GeneratorDecoder(dataGenerator: .always(137)))
    ])
    func container(_ decoder: GeneratorDecoder) throws {
        _ = try decoder.container(keyedBy: StubKey.self)
    }

    @Test("Creates Unkeyed Container", arguments: [
        (GeneratorDecoder(dataGenerator: .always(137)), UInt64(137))
    ])
    func unkeyedContainer(_ decoder: GeneratorDecoder, outcome: UInt64) throws {
        let unkeyedContainer = try decoder.unkeyedContainer() as? GeneratorDecoder.UnkeyedContainer
        let container = try #require(unkeyedContainer)
        #expect(container.dataGenerator.run() == outcome)
    }

    @Test("Creates Decoding Container", arguments: [
        (GeneratorDecoder(dataGenerator: .always(137)), UInt64(137))
    ])
    func singleValueContainer(_ decoder: GeneratorDecoder, outcome: UInt64) throws {
        let container = try decoder.singleValueContainer() as? GeneratorDecoder.SingleValueContainer
        let c = try #require(container)
        #expect(c.dataGenerator.run() == outcome)
    }

    // MARK: GeneratorDecoder.KeyedContainer
    @Suite("Keyed Container")
    struct KeyedContainer {
        @Test("Checks when key is part of Container", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func contains(_ container: GeneratorDecoder.KeyedContainer<StubKey>) throws {
            #expect(container.contains(.init()))
        }

        @Test("Decodes Key", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)), UInt64(137))
        ])
        func decode(_ container: GeneratorDecoder.KeyedContainer<StubKey>, outcome: UInt64) throws {
            let key = try #require(StubKey(intValue: 22))
            let result = try container.decode(Int.self, forKey: key)
            #expect(result == outcome)
        }

        @Test("Decodes Nil Value", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)), true)
        ])
        func decodeNil(_ container: GeneratorDecoder.KeyedContainer<StubKey>, outcome: Bool) throws {
            let key = try #require(StubKey(intValue: 22))
            let value = try container.decodeNil(forKey: key)
            #expect(value == outcome)
        }

        @Test("Creates Nested Container", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func nestedContainer(_ container: GeneratorDecoder.KeyedContainer<StubKey>) throws {
            let key = StubKey()
            let nestedContainer = try container.nestedContainer(keyedBy: StubKey.self, forKey: key)
            #expect(nestedContainer.contains(key))
        }

        @Test("Creates Nested Unkeyed Container", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func nestedUnkeyedContainer(_ container: GeneratorDecoder.KeyedContainer<StubKey>) throws {
            let nestedUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .init()) as? GeneratorDecoder.UnkeyedContainer
            let nestedContainer = try #require(nestedUnkeyedContainer)
            #expect(nestedContainer.dataGenerator.run() == container.dataGenerator.run())
        }

        @Test("Creates Super Decoder", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func superDecoder(_ container: GeneratorDecoder.KeyedContainer<StubKey>) throws {
            let superDecoder = try container.superDecoder()
            let decoder = try #require(superDecoder as? GeneratorDecoder)
            #expect(container.dataGenerator.run() == decoder.dataGenerator.run())
        }

        @Test("Creates Super Decoder for Key", arguments: [
            (StubKey(), GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func superDecoder(key: StubKey, container: GeneratorDecoder.KeyedContainer<StubKey>) throws {
            let decoder = try #require(try container.superDecoder(forKey: key) as? GeneratorDecoder)
            #expect(container.dataGenerator.run() == decoder.dataGenerator.run())
        }
    }

    // MARK: GeneratorDecoder.SingleValueContainer
    @Suite("Single Value Container")
    struct SingleValueContainer {
        public typealias Mock = GeneratorDecoder.SingleValueContainer

        func decodeTest<D: Decodable & Equatable>(
            _ container: Mock,
            outcome: D,
            type: D.Type = D.self
        ) throws {
            let value = try container.decode(type)
            #expect(value == outcome)
        }

        @Test("Decode Nil Value", arguments: [
            (Mock(dataGenerator: .always(137)), true)
        ])
        func decodeNil(_ container: Mock, outcome: Bool) throws {
            let value = container.decodeNil()
            #expect(value == outcome)
        }

        @Test("Decodes Optional Bool Value", arguments: [
            (Mock(dataGenerator: .always(137)), true)
        ])
        func decodeBool(_ container: Mock, outcome: Bool) throws {
            try decodeTest(container, outcome: outcome, type: Bool.self)
        }

        @Test("Decodes Optional String Value", arguments: [
            (Mock(dataGenerator: .always(137)), "137")
        ])
        func decodeString(_ container: Mock, outcome: String) throws {
            try decodeTest(container, outcome: outcome, type: String.self)
        }

        @Test("Decodes Optional Double Value", arguments: [
            (Mock(dataGenerator: .always(137)), 137.0)
        ])
        func decodeDouble(_ container: Mock, outcome: Double) throws {
            try decodeTest(container, outcome: outcome, type: Double.self)
        }

        @Test("Decodes Optional Float Value", arguments: [
            (Mock(dataGenerator: .always(137)), Float(137.0))
        ])
        func decodeFloat(_ container: Mock, outcome: Float) throws {
            try decodeTest(container, outcome: outcome, type: Float.self)
        }

        @Test("Decodes Optional Int Value", arguments: [
            (Mock(dataGenerator: .always(137)), 137)
        ])
        func decodeInt(_ container: Mock, outcome: Int) throws {
            try decodeTest(container, outcome: outcome, type: Int.self)
        }

        @Test("Decodes Optional Int8 Value", arguments: [
            (Mock(dataGenerator: .always(63)), Int8(63))
        ])
        func decodeInt8(_ container: Mock, outcome: Int8) throws {
            try decodeTest(container, outcome: outcome, type: Int8.self)
        }

        @Test("Decodes Optional Int16 Value", arguments: [
            (Mock(dataGenerator: .always(137)), Int16(137))
        ])
        func decodeInt16(_ container: Mock, outcome: Int16) throws {
            try decodeTest(container, outcome: outcome, type: Int16.self)
        }

        @Test("Decodes Optional Int32 Value", arguments: [
            (Mock(dataGenerator: .always(137)), Int32(137))
        ])
        func decodeInt32(_ container: Mock, outcome: Int32) throws {
            try decodeTest(container, outcome: outcome, type: Int32.self)
        }

        @Test("Decodes Optional Int64 Value", arguments: [
            (Mock(dataGenerator: .always(137)), Int64(137))
        ])
        func decodeInt64(_ container: Mock, outcome: Int64) throws {
            try decodeTest(container, outcome: outcome, type: Int64.self)
        }

        @Test("Decodes Optional UInt Value", arguments: [
            (Mock(dataGenerator: .always(137)), UInt(137))
        ])
        func decodeUInt(_ container: Mock, outcome: UInt) throws {
            try decodeTest(container, outcome: outcome, type: UInt.self)
        }

        @Test("Decodes Optional UInt8 Value", arguments: [
            (Mock(dataGenerator: .always(137)), UInt8(137))
        ])
        func decodeUInt8(_ container: Mock, outcome: UInt8) throws {
            try decodeTest(container, outcome: outcome, type: UInt8.self)
        }

        @Test("Decodes Optional UInt16 Value", arguments: [
            (Mock(dataGenerator: .always(137)), UInt16(137))
        ])
        func decodeUInt16(_ container: Mock, outcome: UInt16) throws {
            try decodeTest(container, outcome: outcome, type: UInt16.self)
        }

        @Test("Decodes Optional UInt32 Value", arguments: [
            (Mock(dataGenerator: .always(137)), UInt32(137))
        ])
        func decodeUInt32(_ container: Mock, outcome: UInt32) throws {
            try decodeTest(container, outcome: outcome, type: UInt32.self)
        }

        @Test("Decodes Optional UInt64 Value", arguments: [
            (Mock(dataGenerator: .always(137)), UInt64(137))
        ])
        func decodeUInt64(_ container: Mock, outcome: UInt64) throws {
            try decodeTest(container, outcome: outcome, type: UInt64.self)
        }

        @Test("Decodes Optional Generic Value", arguments: [
            (Mock(dataGenerator: .always(137)), GeneratorDecoder(dataGenerator: .always(137)), Date.self)
        ])
        func decodeAny(_ container: Mock, generator: GeneratorDecoder, type: Date.Type) throws {
            let generatedDate = try Date(from: generator)
            try decodeTest(container, outcome: generatedDate, type: type)
        }
    }

    // MARK: GeneratorDecoder.UnkeyedContainer
    @Suite("Unkeyed Container")
    struct UnkeyedContainer {
        public typealias Mock = GeneratorDecoder.UnkeyedContainer
        
        @Test("Decodes Value and Updates Index", arguments: [
            (Mock(dataGenerator: .always(137), count: 1), 137)
        ])
        func decode(_ container: Mock, outcome: Int) throws {
            var c = container
            #expect(c.isAtEnd == false)
            #expect(c.currentIndex == 0)
            let decodedValue = try c.decode(Int.self)
            #expect(decodedValue == outcome)
            #expect(c.currentIndex == 1)
            #expect(c.isAtEnd)
        }

        @Test("Decodes Optional Value", arguments: [
            (Mock(dataGenerator: .always(137), count: 1), Bool(truncating: 137))
        ])
        func decodeNil(_ container: Mock, outcome: Bool) throws {
            var c = container
            #expect(c.isAtEnd == false)
            #expect(c.currentIndex == 0)
            let value = try c.decodeNil()
            #expect(value == outcome)
            #expect(c.isAtEnd)
            #expect(c.currentIndex == 1)
        }

        @Test("Creates Nested Container", arguments: [
            (Mock(dataGenerator: .always(137), count: 1), StubKey())
        ])
        func nestedContainer(_ container: Mock, outcome: StubKey) throws {
            var c = container
            #expect(c.isAtEnd == false)
            #expect(c.currentIndex == 0)
            _ = try c.nestedContainer(keyedBy: StubKey.self)
        }

        @Test("Creates Unkeyed Container", arguments: [
            (Mock(dataGenerator: .always(137), count: 1), UInt64(137))
        ])
        func nestedUnkeyedContainer(_ container: Mock, outcome: UInt64) throws {
            var c = container
            #expect(c.isAtEnd == false)
            #expect(c.currentIndex == 0)
            let nestedUnkeyedContainer = try c.nestedUnkeyedContainer() as? Mock
            let value = try #require(nestedUnkeyedContainer)
            #expect(value.dataGenerator.run() == outcome)
        }

        @Test("Creates Decoder", arguments: [
            (Mock(dataGenerator: .always(137), count: 1), UInt64(137))
        ])
        func superDecoder(_ container: Mock, outcome: UInt64) throws {
            var c = container
            #expect(c.isAtEnd == false)
            #expect(c.currentIndex == 0)
            let superDecoder = try c.superDecoder() as? GeneratorDecoder
            let value = try #require(superDecoder)
            #expect(value.dataGenerator.run() == outcome)
        }
    }
}
