import Foundation
import Model

protocol LaunchesService {
    func getLaunches(
        search: String?,
        limit: Int?,
        offset: Int?,
        sort: Sort?
    ) async throws -> Query<Launch>

    func getLaunch(id: String) async throws -> Launch
}
