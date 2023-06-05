import Foundation
import DependencyInjection

protocol Service {
    var appState: AppStateService { get }
    var launches: LaunchesService { get }

    static func build() -> Self
}
