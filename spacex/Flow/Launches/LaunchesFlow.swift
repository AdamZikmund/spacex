import Foundation
import Model

protocol LaunchesFlow: Flow {
    func showSortSheet()
    func showErrorAlert(error: Error, tryAgain: @escaping () -> Void)
    func showDetail(launch: Launch)
}
