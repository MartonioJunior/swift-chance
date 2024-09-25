//
//  GeneratorDecoder+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
import Testing
@preconcurrency import Gen
@testable import SwiftChance

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
    func `init`(_ gen: Gen<UInt64>) async throws {
        let decoder: GeneratorDecoder = .init(dataGenerator: gen)
        #expect(decoder.dataGenerator() == 137)
    }
    
    @Test("Creates Keyed Container", arguments: [
        (GeneratorDecoder(dataGenerator: .always(137)))
    ])
    func container(_ decoder: GeneratorDecoder) async throws {
        let container = try decoder.container(keyedBy: StubKey.self)
        #expect(container != nil)
    }

    @Test("Creates Unkeyed Container", arguments: [
        (GeneratorDecoder(dataGenerator: .always(137)), 137)
    ])
    func unkeyedContainer(_ decoder: GeneratorDecoder, outcome: UInt64) async throws {
        let container = #require(decoder.unkeyedContainer() as? GeneratorDecoder.UnkeyedContainer)
        #expect(container.dataGenerator.run() == outcome)
    }
    
    @Test("Creates Decoding Container", arguments: [
        (GeneratorDecoder(dataGenerator: .always(137)), 137)
    ])
    func singleValueContainer(_ decoder: GeneratorDecoder, outcome: UInt64) async throws {
        let container = #require(decoder.singleValueContainer() as? GeneratorDecoder.SingleValueContainer)
        #expect(container.dataGenerator.run() == outcome)
    }
    
    // MARK: GeneratorDecoder.KeyedContainer
    @Suite("Keyed Container")
    struct KeyedContainer {
        @Test("Checks when key is part of Container", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func contains(_ container: GeneratorDecoder.KeyedContainer<StubKey>) async throws {
            #expect(container.contains(.init()))
        }
        
        @Test("Decodes Key", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.KeyedContainer<StubKey>, outcome: UInt64) async throws {
            let key = #require(StubKey(intValue: 22))
            let result = #require(container.decode(Int.self, forKey: key))
            #expect(result == outcome)
        }
        
        @Test("Decodes Nil Value", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)), true)
        ])
        func decodeNil(_ container: GeneratorDecoder.KeyedContainer<StubKey>, outcome: Bool) async throws {
            let key = #require(StubKey(intValue: 22))
            let value = try container.decodeNil(forKey: key)
            #expect(value == outcome)
        }
        
        @Test("Creates Nested Container", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func nestedContainer(_ container: GeneratorDecoder.KeyedContainer<StubKey>) async throws {
            let key = StubKey()
            let nestedContainer = try container.nestedContainer(keyedBy: StubKey.self, forKey: key)
            #expect(nestedContainer.contains(key))
        }
        
        @Test("Creates Nested Unkeyed Container", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func nestedUnkeyedContainer(_ container: GeneratorDecoder.KeyedContainer<StubKey>) async throws {
            let nestedContainer = #require(container.nestedUnkeyedContainer(forKey: .init()) as? GeneratorDecoder.UnkeyedContainer)
            #expect(nestedContainer.dataGenerator.run() == container.dataGenerator.run())
        }
        
        @Test("Creates Super Decoder", arguments: [
            (GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func superDecoder(_ container: GeneratorDecoder.KeyedContainer<StubKey>) async throws {
            let decoder = #require(container.superDecoder() as? GeneratorDecoder)
            #expect(container.dataGenerator.run() == decoder.dataGenerator.run())
        }
        
        @Test("Creates Super Decoder for Key", arguments: [
            (StubKey(), GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137)))
        ])
        func superDecoder(key: StubKey, container: GeneratorDecoder.KeyedContainer<StubKey>) async throws {
            let decoder = #require(container.superDecoder(forKey: key) as? GeneratorDecoder)
            #expect(container.dataGenerator.run() == decoder.dataGenerator.run())
        }
    }
    
    // MARK: GeneratorDecoder.SingleValueContainer
    @Suite("Single Value Container")
    struct SingleValueContainer {
        func decode<D: Decodable & Equatable>(
            _ container: GeneratorDecoder.SingleValueContainer,
            outcome: D,
            type: D.Type = D.self
        ) async throws {
            let value = #require(container.decode(type))
            #expect(value == outcome)
        }

        @Test("Decode Nil Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), true)
        ])
        func decodeNil(_ container: GeneratorDecoder.SingleValueContainer, outcome: Bool) async throws {
            let value = container.decodeNil()
            #expect(value == outcome)
        }

        @Test("Decodes Optional Bool Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), true)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Bool) async throws {
            try await decode(container, outcome: outcome, type: Bool.self)
        }
        
        @Test("Decodes Optional String Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), "137")
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: String) async throws {
            try await decode(container, outcome: outcome, type: String.self)
        }
        
        @Test("Decodes Optional Double Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137.0)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Double) async throws {
            try await decode(container, outcome: outcome, type: Double.self)
        }
        
        @Test("Decodes Optional Float Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137.0)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Float) async throws {
            try await decode(container, outcome: outcome, type: Float.self)
        }
        
        @Test("Decodes Optional Int Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Int) async throws {
            try await decode(container, outcome: outcome, type: Int.self)
        }
        
        @Test("Decodes Optional Int8 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 100 &+ 37)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Int8) async throws {
            try await decode(container, outcome: outcome, type: Int8.self)
        }
        
        @Test("Decodes Optional Int16 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Int16) async throws {
            try await decode(container, outcome: outcome, type: Int16.self)
        }
        
        @Test("Decodes Optional Int32 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Int32) async throws {
            try await decode(container, outcome: outcome, type: Int32.self)
        }
        
        @Test("Decodes Optional Int64 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: Int64) async throws {
            try await decode(container, outcome: outcome, type: Int64.self)
        }
        
        @Test("Decodes Optional UInt Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: UInt) async throws {
            try await decode(container, outcome: outcome, type: UInt.self)
        }
        
        @Test("Decodes Optional UInt8 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: UInt8) async throws {
            try await decode(container, outcome: outcome, type: UInt8.self)
        }
        
        @Test("Decodes Optional UInt16 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: UInt16) async throws {
            try await decode(container, outcome: outcome, type: UInt16.self)
        }
        
        @Test("Decodes Optional UInt32 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: UInt32) async throws {
            try await decode(container, outcome: outcome, type: UInt32.self)
        }
        
        @Test("Decodes Optional UInt64 Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), 137)
        ])
        func decode(_ container: GeneratorDecoder.SingleValueContainer, outcome: UInt64) async throws {
            try await decode(container, outcome: outcome, type: UInt64.self)
        }
        
        @Test("Decodes Optional Generic Value", arguments: [
            (GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137)), Date(from: GeneratorDecoder(dataGenerator: .always(137))), Date.self)
        ])
        func decodeAny(_ container: GeneratorDecoder.SingleValueContainer, outcome: Date, type: Date.Type) async throws {
            try await decode(container, outcome: outcome, type: type)
        }
    }
    
    @Suite("Unkeyed Container")
    struct UnkeyedContainer {
        func decode<D: Decodable & Equatable>(
            _ container: inout GeneratorDecoder.UnkeyedContainer,
            outcome: D,
            type: D.Type = D.self
        ) async throws {
            #expect(container.isAtEnd == false && container.currentIndex == 0)
            let value = #require(container.decode(type))
            #expect(value == outcome)
            #expect(container.isAtEnd && container.currentIndex == 1)
        }
        
        @Test("Decodes Value and Updates Index", arguments: [
            (GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1), 137)
        ])
        func decode(_ container: GeneratorDecoder.UnkeyedContainer, outcome: Int) async throws {
            var c = container
            #expect(c.isAtEnd == false && c.currentIndex == 0)
            let value = #require(c.decode(Int.self))
            #expect(value == outcome)
            #expect(c.isAtEnd && c.currentIndex == 1)
        }
        
        @Test("Decodes Optional Value", arguments: [
            (GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1), false)
        ])
        func decodeNil(_ container: GeneratorDecoder.UnkeyedContainer, outcome: Bool, type: Any) async throws {
            var c = container
            #expect(c.isAtEnd == false && c.currentIndex == 0)
            let value = try c.decodeNil()
            #expect(value == outcome)
            #expect(c.isAtEnd && c.currentIndex == 1)
        }
        
        @Test("Creates Nested Container", arguments: [
            (GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1), 137, Int.self)
        ])
        func nestedContainer(_ container: GeneratorDecoder.UnkeyedContainer, outcome: StubKey) async throws {
            var c = container
            #expect(c.isAtEnd == false && c.currentIndex == 0)
            _ = #require(c.nestedContainer(keyedBy: StubKey.self))
            #expect(c.isAtEnd && c.currentIndex == 1)
        }
        
        @Test("Creates Unkeyed Container", arguments: [
            (GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1), 137)
        ])
        func nestedUnkeyedContainer(_ container: GeneratorDecoder.UnkeyedContainer, outcome: UInt64) async throws {
            var c = container
            #expect(c.isAtEnd == false && c.currentIndex == 0)
            let value = #require(c.nestedUnkeyedContainer() as? GeneratorDecoder.UnkeyedContainer)
            #expect(value.dataGenerator.run() == outcome)
            #expect(c.isAtEnd && c.currentIndex == 1)
        }
        
        @Test("Creates Decoder", arguments: [
            (GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1), 137)
        ])
        func superDecoder(_ container: GeneratorDecoder.UnkeyedContainer, outcome: Int) async throws {
            var c = container
            #expect(c.isAtEnd == false && c.currentIndex == 0)
            let value = #require(c.superDecoder() as? GeneratorDecoder)
            #expect(value.dataGenerator.run() == outcome)
            #expect(c.isAtEnd && c.currentIndex == 1)
        }
    }
}
