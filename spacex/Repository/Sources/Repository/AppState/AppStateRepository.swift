import Foundation
import Model

public protocol AppStateRepository {
    func set(_ state: AppState)
    func getState() -> AppState
}
