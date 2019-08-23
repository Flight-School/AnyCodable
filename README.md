# AnyCodable

[![Build Status][build status badge]][build status]
[![License][license badge]][license]
[![Swift Version][swift version badge]][swift version]
![Cocoapods platforms][cocoapods platforms badge]
[![Cocoapods compatible][cocoapods badge]][cocoapods]
[![Carthage compatible][carthage badge]][carthage]

Type-erased wrappers for `Encodable`, `Decodable`, and `Codable` values.

This functionality is discussed in Chapter 3 of
[Flight School Guide to Swift Codable](https://flight.school/books/codable).

## Installation

### Swift Package Manager

Add the AnyCodable package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/Flight-School/AnyCodable",
        from: "0.2.3"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

### CocoaPods

You can install `AnyCodable` via CocoaPods,
by adding the following line to your `Podfile`:

```ruby
pod 'AnyCodable-FlightSchool', '~> 0.2.3'
```

Run the `pod install` command to download the library
and integrate it into your Xcode project.

> **Note**
> The module name for this library is "AnyCodable" ---
> that is, to use it, you add `import AnyCodable` to the top of your Swift code
> just as you would by any other installation method.
> The pod is called "AnyCodable-FlightSchool"
> because there's an existing pod with the name "AnyCodable".

### Carthage

To use `AnyCodable` in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "Flight-School/AnyCodable" ~> 0.2.3
```

Then run the `carthage update` command to build the framework,
and drag the built AnyCodable.framework into your Xcode project.

## Usage

### AnyEncodable

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

### AnyDecodable

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

### AnyCodable

`AnyCodable` can be used to wrap values for encoding and decoding.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))

[build status]: https://travis-ci.com/Flight-School/AnyCodable
[build status badge]: https://api.travis-ci.com/Flight-School/AnyCodable.svg?branch=master
[license]: https://opensource.org/licenses/MIT
[license badge]: https://img.shields.io/cocoapods/l/AnyCodable-FlightSchool.svg
[swift version]: https://swift.org/download/
[swift version badge]: https://img.shields.io/badge/swift%20version-4.0+-orange.svg
[cocoapods platforms badge]: https://img.shields.io/cocoapods/p/AnyCodable-FlightSchool.svg
[cocoapods]: https://cocoapods.org/pods/AnyCodable-FlightSchool
[cocoapods badge]: https://img.shields.io/cocoapods/v/AnyCodable-FlightSchool.svg
[carthage]: https://github.com/Carthage/Carthage
[carthage badge]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg
