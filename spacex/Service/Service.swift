import Foundation
import DependencyInjection

protocol Service {
    var appState: AppStateService { get }
    var launches: LaunchesService { get }

    static func build() -> Self
}

extension Service {
    static func bootstrap(
        _ provider: DependencyProvider = SharedDependencyProvider.shared
    ) {
        let container = provider.container
        container.register(Service.self) { _ in
            build()
        }
    }
}
