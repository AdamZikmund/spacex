import Foundation
import Model

public class MockLaunchesRepository: LaunchesRepository {
    // MARK: - Lifecycle
    public init() {}
}

// MARK: - LaunchesRepository
extension MockLaunchesRepository {
    public func getLaunches(queryBody: QueryBody) async throws -> Query<Launch> {
        try await .loadJSON("Launches")
    }

    public func getLaunch(id: String) async throws -> Launch {
        try await .loadJSON("Launch")
    }
}
