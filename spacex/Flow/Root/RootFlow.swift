import Foundation
import UIKit
import Model

struct RootFlow: RootFlowProtocol {
    // MARK: - Properties
    private let window: UIWindow
    private let service: Service
    private(set) var navigationController: UINavigationController

    // MARK: - Lifecycle
    init(
        window: UIWindow,
        service: Service
    ) {
        self.window = window
        self.service = service
        self.navigationController = UINavigationController()
    }

    // MARK: - Internal
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        LaunchesFlow(
            service: service,
            navigationController: navigationController
        )
        .start()
    }
}
