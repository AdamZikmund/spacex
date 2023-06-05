import Foundation
import Model

struct FailLaunchesService: LaunchesService {
    // MARK: - Properties
    private let error: Error

    // MARK: - Lifecycle
    init(error: Error) {
        self.error = error
    }

    // MARK: - LaunchesService
    func getLaunches(
        search: String?,
        limit: Int?,
        offset: Int?,
        sort: Sort?
    ) async throws -> Query<Launch> {
        throw error
    }

    func getLaunch(id: String) async throws -> Launch {
        throw error
    }
}
