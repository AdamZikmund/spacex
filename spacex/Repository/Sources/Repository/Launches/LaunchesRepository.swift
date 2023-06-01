import Networking
import Model

public protocol LaunchesRepository {
    func getLaunches(queryBody: QueryBody) async throws -> Query<Launch>
    func getLaunch(id: String) async throws -> Launch
}
