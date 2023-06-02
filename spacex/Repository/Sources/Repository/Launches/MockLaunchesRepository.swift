import Foundation
import Model

public class MockLaunchesRepository: LaunchesRepository {
    // MARK: - Lifecycle
    public init() {}
}

// MARK: - LaunchesRepository
extension MockLaunchesRepository {
    public func getLaunches(queryBody: QueryBody) async throws -> Query<Launch> {
        try await Task.sleep(for: .seconds(1))
        return Query(
            docs: [
                .init(
                    id: UUID().uuidString,
                    name: "Launchpad",
                    date: .now,
                    success: true,
                    links: .init(
                        patch: .init(
                            small: "https://images2.imgbox.com/f9/4a/ZboXReNb_o.png",
                            large: "https://images2.imgbox.com/80/a2/bkWotCIS_o.png"
                        )
                    ),
                    details: "Elon Musk is GOAT",
                    crew: [
                        .init(
                            crew: UUID().uuidString,
                            role: "CEO"
                        )
                    ]
                )
            ],
            offset: 0,
            limit: 1,
            hasNextPage: false
        )
    }

    public func getLaunch(id: String) async throws -> Launch {
        try await Task.sleep(for: .seconds(1))
        return .init(
            id: UUID().uuidString,
            name: "Space X - Launchpad",
            date: .now,
            success: true,
            links: .init(
                patch: .init(
                    small: "https://shorturl.at/yISUY",
                    large: "https://shorturl.at/yISUY"
                )
            ),
            details: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's
""",
            crew: [
                .init(
                    crew: UUID().uuidString,
                    role: "CEO"
                ),
                .init(
                    crew: UUID().uuidString,
                    role: "CTO"
                ),
                .init(
                    crew: UUID().uuidString,
                    role: "CFO"
                ),
                .init(
                    crew: UUID().uuidString,
                    role: "Mechanic"
                )
            ]
        )
    }
}
