import Foundation
import UIKit
import Model

struct LiveRootFlow: RootFlow {
    // MARK: - Properties
    private let service: Service
    private let window: UIWindow
    private(set) var navigationController: UINavigationController

    // MARK: - Lifecycle
    init(
        service: Service,
        window: UIWindow
    ) {
        self.service = service
        self.window = window
        self.navigationController = UINavigationController()
    }

    // MARK: - Internal
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        LiveLaunchesFlow(
            service: service,
            navigationController: navigationController
        )
        .start()
    }
}
