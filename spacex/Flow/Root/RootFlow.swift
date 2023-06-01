import Foundation
import UIKit

class RootFlow {
    // MARK: - Properties
    private let window: UIWindow
    private let service: Service
    private var launchesFlow: LaunchesFlow?

    // MARK: - Lifecycle
    init(
        window: UIWindow,
        service: Service
    ) {
        self.window = window
        self.service = service
    }

    // MARK: - Internal
    func start() {
        launchesFlow = LaunchesFlow(service: service)
        window.rootViewController = launchesFlow?.buildRootController()
        window.makeKeyAndVisible()
    }
}
