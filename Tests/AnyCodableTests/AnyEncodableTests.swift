@testable import AnyCodable
import XCTest

class AnyEncodableTests: XCTestCase {
    func testJSONEncoding() throws {
        let dictionary: [String: AnyEncodable] = [
            "boolean": true,
            "integer": 1,
            "double": 3.14159265358979323846,
            "string": "string",
            "array": [1, 2, 3],
            "nested": [
                "a": "alpha",
                "b": "bravo",
                "c": "charlie",
            ],
        ]

        let encoder = JSONEncoder()

        let json = try encoder.encode(dictionary)
        let encodedJSONObject = try JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary

        let expected = """
        {
            "boolean": true,
            "integer": 1,
            "double": 3.14159265358979323846,
            "string": "string",
            "array": [1, 2, 3],
            "nested": {
                "a": "alpha",
                "b": "bravo",
                "c": "charlie"
            }
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
    }

    func testEncodeNSNumber() throws {
        let dictionary: [String: NSNumber] = [
            "boolean": true,
            "integer": 1,
            "double": 3.14159265358979323846,
        ]

        let encoder = JSONEncoder()

        let json = try encoder.encode(AnyCodable(dictionary))
        let encodedJSONObject = try JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary

        let expected = """
        {
            "boolean": true,
            "integer": 1,
            "double": 3.14159265358979323846,
        }
        """.data(using: .utf8)!
        let expectedJSONObject = try JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary

        XCTAssertEqual(encodedJSONObject, expectedJSONObject)
        XCTAssert(encodedJSONObject["boolean"] is Bool)
        XCTAssert(encodedJSONObject["integer"] is Int)
        XCTAssert(encodedJSONObject["double"] is Double)
    }

    static var allTests = [
        ("testJSONEncoding", testJSONEncoding),
        ("testEncodeNSNumber", testEncodeNSNumber),
    ]
}
