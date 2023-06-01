import Foundation
import Model
import Combine

protocol AppStateService {
    var appStatePublisher: AnyPublisher<AppState, Never> { get }

    func get() -> AppState
    func set(_ state: AppState)
}
