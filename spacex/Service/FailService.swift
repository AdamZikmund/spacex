import Foundation
import Model

struct FailService: Service {
    // MARK: - Properties
    let appState: AppStateService
    let launches: LaunchesService

    // MARK: - Service
    static func build() -> Self {
        return build(error: GeneralError.failure)
    }

    static func build(error: Error) -> Self {
        .init(
            appState: MockAppStateService(),
            launches: FailLaunchesService(error: error)
        )
    }
}
