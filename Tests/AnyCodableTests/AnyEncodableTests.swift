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
        let nsNumber = AnyEncodable(1 as NSNumber)

        let dictionary: [String: AnyEncodable] = [
            "boolean": true,
            "integer": 42,
            "nsNumber": nsNumber,
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
        let json = try JSONEncoder().encode(dictionary)


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
            "nsNumber": 1,
            "someCodable": {
                "string":"String",
                "int":100,
                "bool": true,
                "has_underscore":"another string"
            },
            "null": null
        }
        """
        try XCTAssertJsonAreIdentical(json, expected)
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

        let json = try JSONEncoder().encode(AnyEncodable(dictionary))

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
        """
        try XCTAssertJsonAreIdentical(json, expected)
    }

    func testStringInterpolationEncoding() throws {
        let dictionary: [String: AnyEncodable] = [
            "boolean": "\(true)",
            "integer": "\(42)",
            "double": "\(3.141592653589793)",
            "string": "\("string")",
            "array": "\([1, 2, 3])",
        ]
        let json = try JSONEncoder().encode(dictionary)

        let expected = """
        {
            "boolean": "true",
            "integer": "42",
            "double": "3.141592653589793",
            "string": "string",
            "array": "[1, 2, 3]",
        }
        """

      try XCTAssertJsonAreIdentical(json, expected)
    }
}



func XCTAssertJsonAreIdentical(_ expression1: String, _ expression2: String, options: JSONSerialization.WritingOptions? = nil) throws {
  let data = try XCTUnwrap(expression1.data(using: .utf8))
  try XCTAssertJsonAreIdentical(data, expression2, options: options)
}

func XCTAssertJsonAreIdentical(_ expression1: String, _ expression2: Data, options: JSONSerialization.WritingOptions? = nil) throws {
  let data = try XCTUnwrap(expression1.data(using: .utf8))
  try XCTAssertJsonAreIdentical(data, expression2, options: options)
}

func XCTAssertJsonAreIdentical(_ expression1: Data, _ expression2: String, options: JSONSerialization.WritingOptions? = nil) throws {
  let data = try XCTUnwrap(expression2.data(using: .utf8))
  try XCTAssertJsonAreIdentical(expression1, data, options: options)
}

func XCTAssertJsonAreIdentical(_ expression1: Data, _ expression2: Data, options: JSONSerialization.WritingOptions? = nil) throws {
  var defaultOptions: JSONSerialization.WritingOptions = []
  if #available(iOS 11.0, *) {
    defaultOptions = [.sortedKeys, .prettyPrinted]
  } else {
    defaultOptions = [.prettyPrinted]
  }
  XCTAssertEqual(
    String(data: try JSONSerialization.data(withJSONObject: try JSONSerialization.jsonObject(with: expression1), options: options ?? defaultOptions), encoding: .utf8),
    String(data: try JSONSerialization.data(withJSONObject: try JSONSerialization.jsonObject(with: expression2), options: options ?? defaultOptions), encoding: .utf8)
  )
}
