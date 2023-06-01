import Foundation
import Model
import Combine

class MockAppStateService: AppStateService {
    // MARK: - Properties
    var appStatePublisher: AnyPublisher<AppState, Never> {
        Just(.init()).eraseToAnyPublisher()
    }

    // MARK: - AppStateService
    func get() -> AppState {
        .init()
    }

    func set(_ state: AppState) {}
}
