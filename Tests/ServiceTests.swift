import XCTest
@testable import live

final class ServiceTests: XCTestCase {
    func testService() throws {
        let service = Service.buildLiveService()
        XCTAssertTrue(type(of: service.appStateService) == LiveAppStateService.self)
        XCTAssertTrue(type(of: service.launchesService) == LiveLaunchesService.self)
    }

    func testMockService() throws {
        let service = Service.buildMockService()
        XCTAssertTrue(type(of: service.appStateService) == MockAppStateService.self)
        XCTAssertTrue(type(of: service.launchesService) == MockLaunchesService.self)
    }
}
