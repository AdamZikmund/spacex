import Foundation
import Model

public class LiveAppStateRepository: AppStateRepository {
    private static let StateKey = "state"

    // MARK: - Properties
    // Should be handled same as networking provider, but for demo purpose it is ok :o)
    private let userDefaults: UserDefaults

    private var state: AppState {
        didSet {
            try? userDefaults.setEncodable(state, forKey: Self.StateKey)
        }
    }

    // MARK: - Lifecycle
    public init(userDefaults: UserDefaults, state: AppState?) {
        self.userDefaults = userDefaults
        if let savedState: AppState = try? userDefaults.getDecodable(forKey: Self.StateKey) {
            self.state = state ?? savedState
        } else {
            self.state = state ?? .init()
            try? userDefaults.setEncodable(state, forKey: Self.StateKey)
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
