@testable import AnyCodable
import XCTest

class AnyDecodableTests: XCTestCase {
    func testJSONDecoding() throws {
        let dictionary = try createDictionary()

        XCTAssertEqual(dictionary["boolean"]?.value as! Bool, true)
        XCTAssertEqual(dictionary["integer"]?.value as! Int, 42)
        XCTAssertEqual(dictionary["double"]?.value as! Double, 3.141592653589793, accuracy: 0.001)
        XCTAssertEqual(dictionary["string"]?.value as! String, "string")
        XCTAssertEqual(dictionary["array"]?.value as! [Int], [1, 2, 3])
        XCTAssertEqual(dictionary["nested"]?.value as! [String: String], ["a": "alpha", "b": "bravo", "c": "charlie"])
        XCTAssertEqual(dictionary["null"]?.value as! NSNull, NSNull())
    }
    
    func testEquals() throws {
        let dictionary1 = try createDictionary()
        let dictionary2 = try createDictionary()
        
        XCTAssertEqual(dictionary1, dictionary2)
    }
    
    private func createDictionary() throws -> [String: AnyDecodable] {
        guard let json = """
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
        """.data(using: .utf8) else {
            throw AnyDecodableTestError.toDataConversionFailed
        }
        return try JSONDecoder().decode([String: AnyDecodable].self, from: json)
    }
    
    private enum AnyDecodableTestError: Error {
        case toDataConversionFailed
    }
}
