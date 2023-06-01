import Foundation
import UIKit
import Model

class LaunchesFlow {
    // MARK: - Properties
    private let service: Service
    private var rootController: UIViewController?

    // MARK: - Lifecycle
    init(service: Service) {
        self.service = service
    }

    // MARK: - Internal
    func buildRootController() -> UIViewController {
        if let rootController {
            return rootController
        } else {
            let launchesListController = launchesListController()
            let navigationController = UINavigationController(rootViewController: launchesListController)
            rootController = navigationController
            return navigationController
        }
    }

    // MARK: - Private
    private func launchesListController() -> UIViewController {
        let viewModel = LaunchesViewModel(service: service) { [weak self] in
            self?.showSortSheet()
        } showDetail: { [weak self] launch in
            self?.showDetail(launch: launch)
        } showError: { [weak self] error, tryAgain in
            self?.showErrorAlert(error: error, tryAgain: tryAgain)
        }
        let controller = LaunchesViewController(viewModel: viewModel)
        return controller
    }

    private func showSortSheet() {
        let controller = SortActionSheet.build(
            title: "Sort",
            message: "Sort launches by date",
            options: Sort.Direction.allCases.map(\.rawValue)
        ) { [weak self] option in
            guard let direction = Sort.Direction(rawValue: option) else { return }
            self?.service.appStateService.set(
                .init(
                    sort: .init(
                        key: "date_local",
                        direction: direction
                    )
                )
            )
            self?.rootController?.dismiss(animated: true)
        }
        rootController?.present(controller, animated: true)
    }

    private func showErrorAlert(
        error: Error,
        tryAgain: @escaping () -> Void
    ) {
        let controller = ErrorAlert.build(error: error) { [weak self] in
            tryAgain()
            self?.rootController?.dismiss(animated: true)
        } onCancel: { [weak self] in
            self?.rootController?.dismiss(animated: true)
        }
        rootController?.present(controller, animated: true)
    }

    private func showDetail(launch: Launch) {
        // TODO: Add navigation to detail
    }
}
