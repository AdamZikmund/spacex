import XCTest
@testable import mock
@testable import Model

final class DetailViewModelTests: XCTestCase {
    func testDetailViewModel() throws {
        let date = Date()
        let launch = Launch(
            id: UUID().uuidString,
            name: "Launch",
            date: date,
            success: true,
            links: .init(
                patch: .init(
                    small: "https://shorturl.at/yISUY",
                    large: nil
                )
            ),
            details: "Details", crew: []
        )
        let viewModel = LaunchDetailViewModel(
            service: .buildLiveService(),
            launch: launch,
            launchId: nil
        )
        XCTAssertNotNil(viewModel.launchLoadable.value)
        XCTAssertEqual(viewModel.details, "Details")
        XCTAssertEqual(viewModel.name, "Launch")
        XCTAssertEqual(viewModel.patchURL, URL(string: "https://shorturl.at/yISUY"))
        XCTAssertEqual(viewModel.success, true)
        XCTAssertEqual(viewModel.date, ISO8601DateFormatter().string(from: date))
    }

    func testConfiguration() {}
}
