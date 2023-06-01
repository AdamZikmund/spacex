import Foundation
import Networking
import Model

public class LiveLaunchesRepository: LaunchesRepository {
    // MARK: - Properties
    private let provider: NetworkingProvider

    // MARK: - Lifecycle
    public init(provider: NetworkingProvider) {
        self.provider = provider
    }
}

// MARK: - LaunchesRepository
extension LiveLaunchesRepository {
    public func getLaunches(queryBody: QueryBody) async throws -> Query<Launch> {
        try await provider.sendRequest(to: LanuchesQueryEndpoint(queryBody: queryBody))
    }

    public func getLaunch(id: String) async throws -> Launch {
        try await provider.sendRequest(to: LaunchEndpoint(id: id))
    }
}
