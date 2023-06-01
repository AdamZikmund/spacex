import Foundation
import UIKit

class SortActionSheet {
    // MARK: - Internal
    static func build(
        title: String,
        message: String,
        options: [String],
        onOptionSelect: @escaping (String) -> Void
    ) -> UIAlertController {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        options.forEach { option in
            controller.addAction(
                .init(
                    title: option,
                    style: .default
                ) { _ in
                    onOptionSelect(option)
                }
            )
        }
        return controller
    }
}
