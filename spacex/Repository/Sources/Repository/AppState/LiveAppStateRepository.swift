import Foundation
import Model
import Store

public class LiveAppStateRepository: AppStateRepository {
    private static let StateKey = "state"

    // MARK: - Properties
    private let store: Store

    private var state: AppState {
        didSet {
            try? store.store(state, forKey: Self.StateKey)
        }
    }

    // MARK: - Lifecycle
    public init(store: Store, state: AppState?) {
        self.store = store
        if let stored: AppState = try? store.pick(forKey: Self.StateKey) {
            self.state = state ?? stored
        } else {
            self.state = state ?? .init()
            try? store.store(self.state, forKey: Self.StateKey)
        }
    }
}

// MARK: - AppStateRepository
extension LiveAppStateRepository {
    public func getState() -> AppState {
        return state
    }

    public func set(_ state: AppState) {
        self.state = state
    }
}
