import Foundation
import Repository
import DependencyInjection
import Model

class MockLaunchesService: LaunchesService {
    // MARK: - Properties
    private let repository = MockLaunchesRepository()

    // MARK: - LaunchesService
    func getLaunches(
        search: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        sort: Sort? = nil
    ) async throws -> Query<Launch> {
        let query: QueryBody.Query
        if let search {
            query = .init(text: .init(search: search))
        } else {
            query = .init()
        }
        let options = QueryBody.Options(
            limit: limit,
            offset: offset,
            sort: sort
        )
        return try await repository
            .getLaunches(
                queryBody: .init(
                    query: query,
                    options: options
                )
            )
    }

    func getLaunch(id: String) async throws -> Launch {
        return try await repository.getLaunch(id: id)
    }
}
