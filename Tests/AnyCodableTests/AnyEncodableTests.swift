@testable import AnyCodable
import XCTest

class AnyEncodableTests: XCTestCase {
    func testJSONEncoding() throws {
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
            "null": null
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
    }

    func testEncodeNSNumber() throws {
        let dictionary: [String: NSNumber] = [
            "boolean": true,
            "integer": 42,
            "double": 3.141592653589793,
        ]

        let encoder = JSONEncoder()

        let json = try encoder.encode(AnyEncodable(dictionary))
        let encodedJSONObject = try JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary

        let expected = """
        {
            "boolean": true,
            "integer": 42,
            "double": 3.141592653589793,
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
        XCTAssert(encodedJSONObject["boolean"] is Bool)
        XCTAssert(encodedJSONObject["integer"] is Int)
        XCTAssert(encodedJSONObject["double"] is Double)
    }
    
    #if swift(>=5.0)
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
    #endif

    #if swift(>=5.0)
    static var allTests = [
        ("testJSONEncoding", testJSONEncoding),
        ("testEncodeNSNumber", testEncodeNSNumber),
        ("testStringInterpolationEncoding", testStringInterpolationEncoding),
    ]
    #else
    static var allTests = [
        ("testJSONEncoding", testJSONEncoding),
        ("testEncodeNSNumber", testEncodeNSNumber),
    ]
    #endif
}
