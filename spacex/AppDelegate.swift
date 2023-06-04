import UIKit

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
        setupService()
        setupAppearance()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        rootFlow = LiveRootFlow(window: window)
        rootFlow?.start()
        return true
    }

    // MARK: - Private
    private func setupService() {
#if LIVE
        LiveService.bootstrap()
#else
        MockService.bootstrap()
#endif
    }

    private func setupAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
