import Foundation
import UIKit
import Model
import DependencyInjection

struct LiveLaunchesFlow: LaunchesFlow {
    // MARK: - Properties
    private let service: Service
    private(set) var navigationController: UINavigationController

    private var language: Language {
        service.appState.language
    }

    // MARK: - Lifecycle
    init(
        service: Service,
        navigationController: UINavigationController
    ) {
        self.service = service
        self.navigationController = navigationController
    }

    // MARK: - Flow
    func start() {
        let viewModel = LaunchesViewModel(service: service, flow: self)
        let controller =  LaunchesViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: - LaunchesFlowProtocol
extension LiveLaunchesFlow {
    func showSortSheet() {
        let controller = SortActionSheet.build(
            title: L.LaunchesViewController.Sort.title(language),
            message: L.LaunchesViewController.Sort.message(language),
            options: Sort.Direction.allCases.map(\.rawValue)
        ) { option in
            guard let direction = Sort.Direction(rawValue: option) else { return }
            service.appState.sort = .init(key: "date_local", direction: direction)
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
            service: service,
            launch: nil,
            launchId: launch.id
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
