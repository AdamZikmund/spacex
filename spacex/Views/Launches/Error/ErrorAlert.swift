import Foundation
import UIKit

class ErrorAlert {
    // MARK: - Internal
    static func build(
        error: Error,
        onTryAgain: @escaping () -> Void?,
        onCancel: @escaping () -> Void
    ) -> UIAlertController {
        let controller = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        controller.addAction(
            .init(
                title: "Try again",
                style: .default
            ) { _ in
                onTryAgain()
            }
        )
        controller.addAction(
            .init(title: "Cancel", style: .cancel) { _ in
                onCancel()
            }
        )
        return controller
    }
}
