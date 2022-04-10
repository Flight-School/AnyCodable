@testable import AnyCodable
import XCTest

class AnyEncodableTests: XCTestCase {
    
    struct SomeEncodable: Encodable {
        var string: String
        var int: Int
        var bool: Bool
        var hasUnderscore: String
        
        enum CodingKeys: String,CodingKey {
            case string
            case int
            case bool
            case hasUnderscore = "has_underscore"
        }
    }
    
    func testJSONEncoding() throws {
        
        let someEncodable = AnyEncodable(SomeEncodable(string: "String", int: 100, bool: true, hasUnderscore: "another string"))
        
        let dictionary: [String: AnyEncodable] = [
            "boolean": true,
            "integer": 42,
            "double": 3.141592653589793,
            "string": "string",
            "array": [1, 2, 3],
            "nested": [
                "a": "alpha",
                "b": "bravo",
                "c": "charlie",
            ],
            "someCodable": someEncodable,
            "null": nil
        ]

        let encoder = JSONEncoder()

        let json = try encoder.encode(dictionary)
        let encodedJSONObject = try JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary

        let expected = """
        {
            "boolean": true,
            "integer": 42,
            "double": 3.141592653589793,
            "string": "string",
            "array": [1, 2, 3],
            "nested": {
                "a": "alpha",
                "b": "bravo",
                "c": "charlie"
            },
            "someCodable": {
                "string":"String",
                "int":100,
                "bool": true,
                "has_underscore":"another string"
            },
            "null": null
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
    }

    func testEncodeNSNumber() throws {
        let dictionary: [String: NSNumber] = [
            "boolean": true,
            "char": -127,
            "int": -32767,
            "short": -32767,
            "long": -2147483647,
            "longlong": -9223372036854775807,
            "uchar": 255,
            "uint": 65535,
            "ushort": 65535,
            "ulong": 4294967295,
            "ulonglong": 18446744073709615,
            "double": 3.141592653589793,
        ]

        let encoder = JSONEncoder()

        let json = try encoder.encode(AnyEncodable(dictionary))
        let encodedJSONObject = try JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary

        let expected = """
        {
            "boolean": true,
            "char": -127,
            "int": -32767,
            "short": -32767,
            "long": -2147483647,
            "longlong": -9223372036854775807,
            "uchar": 255,
            "uint": 65535,
            "ushort": 65535,
            "ulong": 4294967295,
            "ulonglong": 18446744073709615,
            "double": 3.141592653589793,
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
        XCTAssert(encodedJSONObject["boolean"] is Bool)

        XCTAssert(encodedJSONObject["char"] is Int8)
        XCTAssert(encodedJSONObject["int"] is Int16)
        XCTAssert(encodedJSONObject["short"] is Int32)
        XCTAssert(encodedJSONObject["long"] is Int32)
        XCTAssert(encodedJSONObject["longlong"] is Int64)

        XCTAssert(encodedJSONObject["uchar"] is UInt8)
        XCTAssert(encodedJSONObject["uint"] is UInt16)
        XCTAssert(encodedJSONObject["ushort"] is UInt32)
        XCTAssert(encodedJSONObject["ulong"] is UInt32)
        XCTAssert(encodedJSONObject["ulonglong"] is UInt64)

        XCTAssert(encodedJSONObject["double"] is Double)
    }

    func testStringInterpolationEncoding() throws {
        let dictionary: [String: AnyEncodable] = [
            "boolean": "\(true)",
            "integer": "\(42)",
            "double": "\(3.141592653589793)",
            "string": "\("string")",
            "array": "\([1, 2, 3])",
        ]

        let encoder = JSONEncoder()

        let json = try encoder.encode(dictionary)
        let encodedJSONObject = try JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary

        let expected = """
        {
            "boolean": "true",
            "integer": "42",
            "double": "3.141592653589793",
            "string": "string",
            "array": "[1, 2, 3]",
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
    }
}
