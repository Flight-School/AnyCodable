import XCTest
@testable import AnyCodable

class AnyEncodableTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testJSONEncoding() {
    let dictionary: [String: AnyEncodable] = [
      "boolean": true,
      "integer": 1,
      "double": 3.14159265358979323846,
      "string": "string",
      "array": [1, 2, 3],
      "nested": [
        "a": "alpha",
        "b": "bravo",
        "c": "charlie"
      ]
    ]
    
    let encoder = JSONEncoder()
    
    let json = try! encoder.encode(dictionary)
    let encodedJSONObject = try! JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary
    
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
    let expectedJSONObject = try! JSONSerialization.jsonObject(with: expected, options: []) as! NSDictionary
    
    XCTAssertEqual(encodedJSONObject, expectedJSONObject)
  }
  
  static var allTests = [
    ("testJSONEncoding", testJSONEncoding),
    ]
  
}
