import Foundation
import UIKit
import SwiftUI
import Model

class LaunchDetailViewController: UIViewController {
    // MARK: - Properties
    private let flow: LaunchesFlow
    private let launch: Launch?
    private let launchId: String?

    // MARK: - Lifecycle
    init(
        flow: LaunchesFlow,
        launch: Launch?,
        launchId: String?
    ) {
        self.flow = flow
        self.launch = launch
        self.launchId = launchId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHostingController()
    }

    // MARK: - Private
    private func setupHostingController() {
        let viewModel = LaunchDetailViewModel(
            flow: flow,
            launch: launch,
            launchId: launchId
        )
        let controller = UIHostingController(rootView: LaunchDetailView(viewModel: viewModel))
        guard let swiftUIView = controller.view else { return }
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        addChild(controller)
        view.addSubview(swiftUIView)
        NSLayoutConstraint.activate([
            swiftUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            swiftUIView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        controller.didMove(toParent: self)
    }
}
