@testable import AnyCodable
import XCTest



class AnyCodableTests: XCTestCase {
    
    struct SomeCodable: Codable {
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
    
    func testJSONDecoding() throws {
        let json = """
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

        let decoder = JSONDecoder()
        let dictionary = try decoder.decode([String: AnyCodable].self, from: json)

        XCTAssertEqual(dictionary["boolean"]?.value as! Bool, true)
        XCTAssertEqual(dictionary["integer"]?.value as! Int, 42)
        XCTAssertEqual(dictionary["double"]?.value as! Double, 3.141592653589793, accuracy: 0.001)
        XCTAssertEqual(dictionary["string"]?.value as! String, "string")
        XCTAssertEqual(dictionary["array"]?.value as! [Int], [1, 2, 3])
        XCTAssertEqual(dictionary["nested"]?.value as! [String: String], ["a": "alpha", "b": "bravo", "c": "charlie"])
        XCTAssertEqual(dictionary["null"]?.value as! NSNull, NSNull())
    }

    func testJSONDecodingEquatable() throws {
        let json = """
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
        
        let decoder = JSONDecoder()
        let dictionary1 = try decoder.decode([String: AnyCodable].self, from: json)
        let dictionary2 = try decoder.decode([String: AnyCodable].self, from: json)

        XCTAssertEqual(dictionary1["boolean"], dictionary2["boolean"])
        XCTAssertEqual(dictionary1["integer"], dictionary2["integer"])
        XCTAssertEqual(dictionary1["double"], dictionary2["double"])
        XCTAssertEqual(dictionary1["string"], dictionary2["string"])
        XCTAssertEqual(dictionary1["array"], dictionary2["array"])
        XCTAssertEqual(dictionary1["nested"], dictionary2["nested"])
        XCTAssertEqual(dictionary1["null"], dictionary2["null"])
    }

    func testJSONEncoding() throws {
        
        let someCodable = AnyCodable(SomeCodable(string: "String", int: 100, bool: true, hasUnderscore: "another string"))

        let injectedValue = 1234
        let dictionary: [String: AnyCodable] = [
            "boolean": true,
            "integer": 42,
            "double": 3.141592653589793,
            "string": "string",
            "stringInterpolation": "string \(injectedValue)",
            "array": [1, 2, 3],
            "nested": [
                "a": "alpha",
                "b": "bravo",
                "c": "charlie",
            ],
            "someCodable": someCodable,
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
            "stringInterpolation": "string 1234",
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
}
