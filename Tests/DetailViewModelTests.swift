import XCTest
@testable import mock
@testable import Model
@testable import DependencyInjection

final class DetailViewModelTests: XCTestCase {
    @MainActor func testGetLaunchSuccess() async throws {
        let viewModel = LaunchDetailViewModel(
            service: MockService.build(),
            launch: nil,
            launchId: "62dd70d5202306255024d139"
        )
        XCTAssertTrue(viewModel.isLoading)
        await viewModel.getLaunch().value
        XCTAssertTrue(viewModel.viewState == .success)
        XCTAssertEqual(viewModel.name, "Crew-5")
        XCTAssertEqual(viewModel.details, "Best flight ever")
        XCTAssertEqual(viewModel.crew.count, 4)
        XCTAssertEqual(viewModel.success, true)
        XCTAssertEqual(viewModel.patchURL, URL(string: "https://images2.imgbox.com/eb/d8/D1Yywp0w_o.png"))
        XCTAssertEqual(viewModel.date, "2022-10-05T16:00:00Z")
    }

    @MainActor func testGetLaunchFailure() async throws {
        let viewModel = LaunchDetailViewModel(
            service: FailService.build(),
            launch: nil,
            launchId: "62dd70d5202306255024d139"
        )
        XCTAssertTrue(viewModel.isLoading)
        await viewModel.getLaunch().value
        XCTAssertTrue(viewModel.viewState == .failure)
        XCTAssertTrue(viewModel.name.isEmpty)
        XCTAssertTrue(viewModel.details.isEmpty)
        XCTAssertTrue(viewModel.crew.isEmpty)
        XCTAssertFalse(viewModel.success)
        XCTAssertTrue(viewModel.date.isEmpty)
        XCTAssertNil(viewModel.patchURL)
        XCTAssertFalse(viewModel.errorTitle.isEmpty)
        XCTAssertFalse(viewModel.tryAgainTitle.isEmpty)
    }

    @MainActor func testMissingLaunchOrLaunchId() async throws {
        let viewModel = LaunchDetailViewModel(
            service: FailService.build(),
            launch: nil,
            launchId: nil
        )
        XCTAssertTrue(viewModel.isLoading)
        await viewModel.getLaunch().value
        XCTAssertTrue(viewModel.viewState == .failure)
        XCTAssertTrue(viewModel.name.isEmpty)
        XCTAssertTrue(viewModel.details.isEmpty)
        XCTAssertTrue(viewModel.crew.isEmpty)
        XCTAssertFalse(viewModel.success)
        XCTAssertTrue(viewModel.date.isEmpty)
        XCTAssertNil(viewModel.patchURL)
        XCTAssertFalse(viewModel.errorTitle.isEmpty)
        XCTAssertFalse(viewModel.tryAgainTitle.isEmpty)
    }

    @MainActor func testInjectingModel() async throws {
        let date = Date()
        let launch = Launch(
            id: "62dd70d5202306255024d139",
            name: "Launch",
            date: date,
            success: true,
            links: .init(patch: .init(small: "https://someurl.com/img.png", large: nil)),
            details: "Rocket launch",
            crew: [
                .init(crew: "1", role: "CEO")
            ]
        )
        let viewModel = LaunchDetailViewModel(
            service: MockService.build(),
            launch: launch,
            launchId: nil
        )
        await viewModel.getLaunch().value
        XCTAssertTrue(viewModel.viewState == .success)
        XCTAssertEqual(viewModel.name, "Launch")
        XCTAssertEqual(viewModel.details, "Rocket launch")
        XCTAssertEqual(viewModel.crew.count, 1)
        XCTAssertEqual(viewModel.crew.first?.crew, "1")
        XCTAssertEqual(viewModel.crew.first?.role, "CEO")
        XCTAssertEqual(viewModel.success, true)
        XCTAssertEqual(viewModel.patchURL, URL(string: "https://someurl.com/img.png"))
        XCTAssertEqual(viewModel.date, ISO8601DateFormatter().string(from: date))
    }

    @MainActor func testPlacholders() throws {
        let viewModel = LaunchDetailViewModel(
            service: MockService.build(),
            launch: nil,
            launchId: nil
        )
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertFalse(viewModel.name.isEmpty)
        XCTAssertFalse(viewModel.details.isEmpty)
        XCTAssertFalse(viewModel.crew.isEmpty)
        XCTAssertTrue(viewModel.success)
        XCTAssertFalse(viewModel.date.isEmpty)
        XCTAssertNil(viewModel.patchURL)
    }
}
