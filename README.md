# AnyCodable

[![Build Status][build status badge]][build status] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Type-erased wrappers for `Encodable`, `Decodable`, and `Codable` values.

This functionality is discussed in Chapter 3 of
[Flight School Guide to Swift Codable](https://flight.school/books/codable).

## AnyEncodable

```swift
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
let json = try! encoder.encode(dictionary)
```

## AnyDecodable

```swift
let json = """
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

let decoder = JSONDecoder()
let dictionary = try! decoder.decode([String: AnyDecodable].self, from: json)
```

## AnyCodable

`AnyCodable` can be used to wrap values for encoding and decoding.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))

[build status]: https://travis-ci.com/Flight-School/AnyCodable
[build status badge]: https://api.travis-ci.com/Flight-School/AnyCodable.svg?branch=master
