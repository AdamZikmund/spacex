import XCTest
@testable import mock
@testable import Model

final class MainFlowTests: XCTestCase {
    @MainActor func testNavigationToDetail() throws {
        let service = MockService.build()
        let flowViewModel = MainFlowViewModel(service: service)
        let launchesViewModel = flowViewModel.buildLaunchesViewModel()
        let launch = Launch(
            id: "62dd70d5202306255024d139",
            name: "Launch",
            date: .now,
            success: true,
            links: .init(patch: .init(small: "https://someurl.com/img.png", large: nil)),
            details: "Rocket launch",
            crew: [
                .init(crew: "1", role: "CEO")
            ]
        )
        XCTAssertTrue(flowViewModel.navigationPath.isEmpty)
        XCTAssertNil(flowViewModel.presentationItem)
        launchesViewModel.openDetail(launch: launch)
        XCTAssertEqual(flowViewModel.navigationPath.count, 1)
        XCTAssertNil(flowViewModel.presentationItem)
    }

    @MainActor func testNavigationToSort() throws {
        let service = MockService.build()
        let flowViewModel = MainFlowViewModel(service: service)
        let launchesViewModel = flowViewModel.buildLaunchesViewModel()
        XCTAssertTrue(flowViewModel.navigationPath.isEmpty)
        XCTAssertNil(flowViewModel.presentationItem)
        launchesViewModel.openSort()
        XCTAssertTrue(flowViewModel.navigationPath.isEmpty)
        XCTAssertNotNil(flowViewModel.presentationItem)
        if case let .sort(sortViewModel) = flowViewModel.presentationItem {
            sortViewModel.apply()
        }
        XCTAssertNil(flowViewModel.presentationItem)
    }
}
