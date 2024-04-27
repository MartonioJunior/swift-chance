//
//  GeneratorDecoder+Tests.swift
//  
//
//  Created by Martônio Júnior on 21/03/24.
//

import XCTest
@testable import SwiftChance

// MARK: Stubs
extension GeneratorDecoder_Tests {
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
}

final class GeneratorDecoder_Tests: XCTestCase {
    // MARK: Test Cases
    func test_init_createsNewDecoder() {
        let decoder = GeneratorDecoder(dataGenerator: .always(137))

        XCTAssertEqual(decoder.dataGenerator(), 137)
    }
    
    func test_container_createsKeyedContainer() {
        let decoder = GeneratorDecoder(dataGenerator: .always(137))

        let container = try? decoder.container(keyedBy: StubKey.self)
        
        XCTAssertNotNil(container)
    }
    
    func test_unkeyedContainer_createsUnkeyedContainer() {
        let decoder = GeneratorDecoder(dataGenerator: .always(137))

        let container = try? decoder.unkeyedContainer() as? GeneratorDecoder.UnkeyedContainer
        
        XCTAssertEqual(container?.dataGenerator.run(), 137)
    }
    
    func test_singleValueContainer_createsDecodingContainer() {
        let decoder = GeneratorDecoder(dataGenerator: .always(137))

        let container = try? decoder.singleValueContainer() as? GeneratorDecoder.SingleValueContainer
        
        XCTAssertEqual(container?.dataGenerator.run(), 137)
    }
    
    // MARK: KeyedContainer
    func test_contains_checksWhenKeyIsPartOfContainer() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        XCTAssertTrue(container.contains(.init()))
    }
    
    func test_decode_decodesKey() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        let value = try? container.decode(Int.self, forKey: .init(intValue: 22)!)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decodeNil_decodesNilValue() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        let value = try? container.decodeNil(forKey: .init(stringValue: "hi")!)
        
        XCTAssert(value == true)
    }
    
    func test_nestedContainer_createsContainer() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        let nestedContainer = try? container.nestedContainer(keyedBy: StubKey.self, forKey: .init())
        
        XCTAssertNotNil(nestedContainer)
    }
    
    func test_nestedUnkeyedContainer_createsContainer() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        let nestedContainer = try? container.nestedUnkeyedContainer(forKey: .init()) as? GeneratorDecoder.UnkeyedContainer
        
        XCTAssertEqual(container.dataGenerator.run(), nestedContainer?.dataGenerator.run())
    }
    
    func test_superDecoder_createsDecoder() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        let decoder = try? container.superDecoder() as? GeneratorDecoder
        
        XCTAssertEqual(container.dataGenerator.run(), decoder?.dataGenerator.run())
    }
    
    func test_superDecoder_key_createsDecoder() {
        let container = GeneratorDecoder.KeyedContainer<StubKey>(dataGenerator: .always(137))
        
        let decoder = try? container.superDecoder(forKey: .init()) as? GeneratorDecoder
        
        XCTAssertEqual(container.dataGenerator.run(), decoder?.dataGenerator.run())
    }
    
    // MARK: Single Value Container
    func test_decodeNil_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = container.decodeNil()
        
        XCTAssertTrue(value)
    }
    
    func test_decode_bool_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Bool.self)
        
        XCTAssert(value == true)
    }
    
    func test_decode_string_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(String.self)
        
        XCTAssertEqual(value, "137")
    }
    
    func test_decode_double_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Double.self)
        
        XCTAssertEqual(value, 137.0)
    }
    
    func test_decode_float_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Float.self)
        
        XCTAssertEqual(value, 137.0)
    }
    
    func test_decode_int_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Int.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_int8_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Int8.self)
        
        XCTAssertEqual(value, 100 &+ 37)
    }
    
    func test_decode_int16_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Int16.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_int32_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Int32.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_int64_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Int64.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_uint_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(UInt.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_uint8_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(UInt8.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_uint16_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(UInt16.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_uint32_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(UInt32.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_uint64_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(UInt64.self)
        
        XCTAssertEqual(value, 137)
    }
    
    func test_decode_generics_decodesOptionalValue() {
        let container = GeneratorDecoder.SingleValueContainer(dataGenerator: .always(137))
        
        let value = try? container.decode(Date.self)
        
        let date = try? Date(from: GeneratorDecoder(dataGenerator: .always(137)))
        
        XCTAssertEqual(value, date)
    }
    
    // MARK: UnkeyedContainer
    func test_decode_decodesValueAndUpdatesIndex() {
        var container = GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1)
        
        XCTAssertFalse(container.isAtEnd)
        
        let value = try? container.decode(Int.self)
        
        XCTAssertEqual(value, 137)
        XCTAssertEqual(container.currentIndex, 1)
        XCTAssertTrue(container.isAtEnd)
    }
    
    func test_unkeyed_decodeNil_decodesOptionalValue() {
        var container = GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1)
        
        let value = try? container.decodeNil()
        
        XCTAssert(value == true)
    }
    
    func test_unkeyed_nestedContainer_createsNestedContainer() {
        var container = GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1)
        
        let nestedContainer = try? container.nestedContainer(keyedBy: StubKey.self)
        
        XCTAssertNotNil(nestedContainer)
    }
    
    func test_unkeyed_nestedUnkeyedContainer_createsUnkeyedContainer() {
        var container = GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1)
        
        let nestedContainer = try? container.nestedUnkeyedContainer() as? GeneratorDecoder.UnkeyedContainer
        
        XCTAssertEqual(container.dataGenerator.run(), nestedContainer?.dataGenerator.run())
    }
    
    func test_unkeyed_superDecoder_createsDecoder() {
        var container = GeneratorDecoder.UnkeyedContainer(dataGenerator: .always(137), count: 1)
        
        let decoder = try? container.superDecoder() as? GeneratorDecoder
        
        XCTAssertEqual(container.dataGenerator.run(), decoder?.dataGenerator.run())
    }
}
