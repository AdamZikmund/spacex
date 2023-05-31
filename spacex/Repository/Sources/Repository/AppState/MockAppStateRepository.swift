import Foundation
import Model

public class MockAppStateRepository: AppStateRepository {
    // MARK: - Lifecycle
    public init() {}
}

// MARK: - AppStateRepository
extension MockAppStateRepository {
    public func getState() -> AppState {
        .init(sort: .init(key: "date_local", direction: .desc))
    }

    public func set(_ state: AppState) {}
}
