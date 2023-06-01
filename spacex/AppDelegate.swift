import UIKit
import Networking
import Model
import Repository

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    private var rootFlow: RootFlow?

    // MARK: - UIApplicationDelegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let service = Service.buildLiveService()
        rootFlow = RootFlow(window: window, service: service)
        rootFlow?.start()
        return true
    }
}
