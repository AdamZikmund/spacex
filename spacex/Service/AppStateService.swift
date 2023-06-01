import Foundation
import Repository
import Swinject
import Model
import Combine

class AppStateService {
    // MARK: - Properties
    private let repository: AppStateRepository
    private let appStateSubject: CurrentValueSubject<AppState, Never>

    var appStatePublisher: AnyPublisher<AppState, Never> {
        appStateSubject.eraseToAnyPublisher()
    }

    // MARK: - Lifecycle
    init(container: Container) {
        let repository = container.resolve(AppStateRepository.self)!
        self.repository = repository
        self.appStateSubject = .init(repository.getState())
    }

    // MARK: - Internal
    func get() -> AppState {
        repository.getState()
    }

    func set(_ state: AppState) {
        repository.set(state)
        appStateSubject.send(state)
    }
}
