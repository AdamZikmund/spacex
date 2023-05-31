import Foundation
import Networking
import Model

public class LiveLaunchesRepository: LaunchesRepository {
    // MARK: - Properties
    private let provider: Provider

    // MARK: - Lifecycle
    public init(provider: Provider) {
        self.provider = provider
    }
}

// MARK: - LaunchesRepository
extension LiveLaunchesRepository {
    public func getLaunchpads(queryBody: QueryBody) async throws -> Query<Launchpad> {
        try await provider.sendRequest(to: LanuchesQueryEndpoint(queryBody: queryBody))
    }
}
