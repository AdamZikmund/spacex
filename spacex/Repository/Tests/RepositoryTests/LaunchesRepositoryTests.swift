import XCTest
@testable import Repository
@testable import Networking

final class LaunchesRepositoryTests: XCTestCase {
    private let repository: LiveLaunchesRepository = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let repository = LiveLaunchesRepository(
            provider: EndpointProvider(
                networking: URLSessionNetworking(session: .shared),
                decoder: decoder,
                encoder: encoder,
                baseURL: "https://api.spacexdata.com/v5",
                headers: ["Content-Type": "application/json"]
            )
        )
        return repository
    }()

    @MainActor
    func testGetLaunches() async throws {
        let query = try await repository.getLaunches(queryBody: .init())
        XCTAssertFalse(query.docs.isEmpty)
    }

    @MainActor
    func testGetLaunch() async throws {
        let launch = try await repository.getLaunch(id: "633f71240531f07b4fdf59bb")
        XCTAssertNotNil(launch)
    }
}
