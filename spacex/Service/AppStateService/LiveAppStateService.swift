import Foundation
import Repository
import DependencyInjection
import Model
import Combine

class LiveAppStateService: AppStateService {
    // MARK: - Properties
    private let repository: AppStateRepository
    private let appState: CurrentValueSubject<AppState, Never>
    private let dispatchQueue = DispatchQueue(label: "DispatchQueue.LiveAppStateService")
    private var bag = Set<AnyCancellable>()

    var publisher: AnyPublisher<AppState, Never> {
        appState
            .removeDuplicates()
            .share()
            .eraseToAnyPublisher()
    }

    // MARK: - Lifecycle
    init(resolver: Resolver) {
        let repository = resolver.resolve(AppStateRepository.self)
        self.repository = repository
        self.appState = .init(repository.getState())
        self.setupBindings()
    }

    // MARK: - Private
    private func setupBindings() {
        publisher
            .receive(on: dispatchQueue)
            .sink { [weak self] state in
                self?.repository.set(state)
            }
            .store(in: &bag)
    }

    // MARK: - AppStateService
    func transaction(_ transaction: @escaping (inout Model.AppState) -> Void) {
        dispatchQueue.sync {
            var state = appState.value
            transaction(&state)
            appState.value = state
        }
    }

    subscript<Value>(dynamicMember keyPath: WritableKeyPath<AppState, Value>) -> Value {
        get { appState.value[keyPath: keyPath] }
        set { appState.value[keyPath: keyPath] = newValue }
    }
}
