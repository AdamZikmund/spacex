import Foundation
import UIKit
import Model
import DependencyInjection

struct LiveLaunchesFlow: LaunchesFlow {
    // MARK: - Properties
    @Inject private var service: Service
    private(set) var navigationController: UINavigationController

    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Flow
    func start() {
        let viewModel = LaunchesViewModel(flow: self)
        let controller =  LaunchesViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: - LaunchesFlowProtocol
extension LiveLaunchesFlow {
    func showSortSheet() {
        let controller = SortActionSheet.build(
            title: "LaunchesViewController.Sort.Title".localized(),
            message: "LaunchesViewController.Sort.Message".localized(),
            options: Sort.Direction.allCases.map(\.rawValue)
        ) { option in
            guard let direction = Sort.Direction(rawValue: option) else { return }
            service.appState.set(
                .init(
                    sort: .init(
                        key: "date_local",
                        direction: direction
                    )
                )
            )
            navigationController.dismiss(animated: true)
        }
        navigationController.present(controller, animated: true)
    }

    func showErrorAlert(
        error: Error,
        tryAgain: @escaping () -> Void
    ) {
        let controller = ErrorAlert.build(error: error) {
            tryAgain()
            navigationController.dismiss(animated: true)
        } onCancel: {
            navigationController.dismiss(animated: true)
        }
        navigationController.present(controller, animated: true)
    }

    func showDetail(launch: Launch) {
        let controller = LaunchDetailViewController(
            flow: self,
            launch: nil,
            launchId: launch.id
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
