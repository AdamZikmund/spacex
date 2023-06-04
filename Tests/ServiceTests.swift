import XCTest
@testable import mock

final class ServiceTests: XCTestCase {
    func testService() throws {
        let service = LiveService.build()
        XCTAssertTrue(type(of: service.appState) == LiveAppStateService.self)
        XCTAssertTrue(type(of: service.launches) == LiveLaunchesService.self)
    }

    func testMockService() throws {
        let service = MockService.build()
        XCTAssertTrue(type(of: service.appState) == MockAppStateService.self)
        XCTAssertTrue(type(of: service.launches) == MockLaunchesService.self)
    }
}
