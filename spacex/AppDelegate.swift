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
        setupAppearance()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let service = buildService()
        rootFlow = LiveRootFlow(service: service, window: window)
        rootFlow?.start()
        return true
    }

    // MARK: - Private
    private func buildService() -> Service {
#if LIVE
        LiveService.build()
#else
        MockService.build()
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
