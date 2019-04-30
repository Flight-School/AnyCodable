import Foundation
import AnyCodable

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
let data = try encoder.encode(dictionary)

let string = String(data: data, encoding: .utf8)

let decoder = JSONDecoder()
let object = try decoder.decode([String: AnyDecodable].self, from: data)
