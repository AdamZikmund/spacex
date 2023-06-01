import XCTest
@testable import mock

final class ConfigurationTests: XCTestCase {
    func testLiveConfiguration() throws {
        let configuration = LiveConfiguration()
        XCTAssertEqual(configuration.baseURL, "https://api.spacexdata.com/v5")
        XCTAssertEqual(configuration.headers, ["Content-Type": "application/json"])
    }

    func testMockConfiguration() throws {
        let configuration = MockConfiguration()
        XCTAssertEqual(configuration.baseURL, "https://api.spacexdata.com/v4")
        XCTAssertEqual(configuration.headers, ["Content-Type": "application/json"])
    }
}
