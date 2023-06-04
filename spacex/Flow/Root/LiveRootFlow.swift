import Foundation
import UIKit
import Model

struct LiveRootFlow: RootFlow {
    // MARK: - Properties
    private let window: UIWindow
    private(set) var navigationController: UINavigationController

    // MARK: - Lifecycle
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    // MARK: - Internal
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        LiveLaunchesFlow(navigationController: navigationController)
            .start()
    }
}
