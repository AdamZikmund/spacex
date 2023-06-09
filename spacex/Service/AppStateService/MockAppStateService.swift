import Foundation
import Model
import Combine

class MockAppStateService: AppStateService {
    // MARK: - Properties
    private var appState = AppState()

    var publisher: AnyPublisher<AppState, Never> {
        Just(.init()).eraseToAnyPublisher()
    }

    // MARK: - AppStateService
    func transaction(_ transaction: @escaping (inout AppState) -> Void) {}

    subscript<Value>(dynamicMember keyPath: WritableKeyPath<AppState, Value>) -> Value {
        get { appState[keyPath: keyPath] }
        set { appState[keyPath: keyPath] = newValue }
    }
}
