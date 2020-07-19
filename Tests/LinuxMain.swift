@testable import AnyCodableTests
import XCTest

// the tests can be "discovered" on Linux with `swift test --enable-test-discovery`
XCTMain([
    testCase(AnyCodableTests.allTests),
    testCase(AnyDecodableTests.allTests),
    testCase(AnyEncodableTests.allTests),
])
