import Networking
import Model

public protocol LaunchesRepository {
    func getLaunchpads(queryBody: QueryBody) async throws -> Query<Launchpad>
}
