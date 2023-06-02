import Foundation
import SwiftUI
import UIKit

struct UIViewControllerRepresentable: UIViewRepresentable {
    // MARK: - Properties
    private let controller: UIViewController

    // MARK: - Lifecycle
    init(controller: UIViewController) {
        self.controller = controller
    }

    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        controller.viewDidLoad()
        return controller.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
