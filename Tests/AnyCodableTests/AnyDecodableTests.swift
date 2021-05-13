@testable import AnyCodable
import XCTest

class AnyDecodableTests: XCTestCase {
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
        let dictionary = try decoder.decode([String: AnyDecodable].self, from: json)

        XCTAssertEqual(dictionary["boolean"]?.value as! Bool, true)
        XCTAssertEqual(dictionary["integer"]?.value as! Int, 42)
        XCTAssertEqual(dictionary["double"]?.value as! Double, 3.141592653589793, accuracy: 0.001)
        XCTAssertEqual(dictionary["string"]?.value as! String, "string")
        XCTAssertEqual(dictionary["array"]?.value as! [Int], [1, 2, 3])
        XCTAssertEqual(dictionary["nested"]?.value as! [String: String], ["a": "alpha", "b": "bravo", "c": "charlie"])
        XCTAssertEqual(dictionary["null"]?.value as! NSNull, NSNull())
    }
}
