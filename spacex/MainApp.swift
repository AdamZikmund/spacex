import SwiftUI

@main
struct MainApp: App {
    // MARK: - Properties
    private let service: Service

    // MARK: - Lifecycle
    init() {
#if LIVE
        self.service = LiveService.build()
#else
        self.service = MockService.build()
#endif
    }

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            MainFlowView(
                viewModel: .init(service: service)
            )
        }
    }
}
