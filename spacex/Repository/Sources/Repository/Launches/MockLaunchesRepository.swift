import Foundation
import Model

public class MockLaunchesRepository: LaunchesRepository {
    // MARK: - Properties
    private let delay: Duration?

    // MARK: - Lifecycle
    public init(delay: Duration? = nil) {
        self.delay = delay
    }
}

// MARK: - LaunchesRepository
extension MockLaunchesRepository {
    public func getLaunches(queryBody: QueryBody) async throws -> Query<Launch> {
        try await .loadJSON("Launches", delay: delay)
    }

    public func getLaunch(id: String) async throws -> Launch {
        try await .loadJSON("Launch", delay: delay)
    }
}
