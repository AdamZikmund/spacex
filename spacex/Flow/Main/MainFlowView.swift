import Foundation
import SwiftUI
import ViewComponent

struct MainFlowView: View {
    typealias Navigation = MainFlowViewModel.Navigation

    // MARK: - Properties
    @StateObject private var viewModel: MainFlowViewModel

    // MARK: - Lifecycle
    init(viewModel: MainFlowViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    // MARK: - Body
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            LaunchesV2View(
                viewModel: viewModel.buildLaunchesViewModel()
            )
            .navigationDestination(for: Navigation.self) { navigation in
                switch navigation {
                case let .detail(viewModel):
                    LaunchDetailView(
                        viewModel: viewModel
                    )
                }
            }
        }
        .sheet(item: $viewModel.presentationItem) { presentation in
            switch presentation {
            case let .sort(viewModel):
                SortView(viewModel: viewModel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
