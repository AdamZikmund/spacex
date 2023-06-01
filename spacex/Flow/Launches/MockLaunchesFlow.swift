import Foundation
import UIKit
import Model

struct MockLaunchesFlow: LaunchesFlow {
    var navigationController: UINavigationController = UINavigationController()

    func start() {}
    func showSortSheet() {}
    func showErrorAlert(error: Error, tryAgain: @escaping () -> Void) {}
    func showDetail(launch: Launch) {}
}
