import Foundation
import Repository
import Swinject
import Model

class AppStateService {
    // MARK: - Properties
    private let repository: AppStateRepository

    // MARK: - Lifecycle
    init(container: Container) {
        self.repository = container.resolve(AppStateRepository.self)!
    }

    // MARK: - Internal
    func get() -> AppState {
        repository.getState()
    }

    func set(_ state: AppState) {
        repository.set(state)
    }
}
