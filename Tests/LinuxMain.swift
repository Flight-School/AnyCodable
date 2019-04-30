@testable import AnyCodableTests
import XCTest

XCTMain([
    testCase(AnyCodableTests.allTests),
    testCase(AnyDecodableTests.allTests),
    testCase(AnyEncodableTests.allTests),
])
