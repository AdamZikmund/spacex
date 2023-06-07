import Foundation
import Combine
import Model

@MainActor final class MainFlowViewModel: ObservableObject {
    // MARK: - Properties
    @Published var navigationPath = [Navigation]()
    @Published var presentationItem: Presentation?

    private let service: Service
    private var bag = Set<AnyCancellable>()

    private var sort: Sort {
        get {
            service.appState.get().sort ?? .init(key: "date_local", direction: .desc)
        }
        set {
            service.appState.set(.init(sort: newValue))
        }
    }

    // MARK: - Lifecycle
    init(service: Service) {
        self.service = service
    }

    // MARK: - Internal
    func buildLaunchesViewModel() -> LaunchesV2ViewModel {
        let viewModel = LaunchesV2ViewModel(service: service)
        viewModel
            .navigateToDetail
            .sink { [weak self] launch in
                self?.navigateToDetail(launch: launch)
            }
            .store(in: &bag)
        viewModel
            .navigateToSort
            .sink { [weak self] _ in
                self?.presentSort()
            }
            .store(in: &bag)
        return viewModel
    }

    func buildLaunchDetailViewModel(launch: Launch) -> LaunchDetailViewModel {
        let viewModel = LaunchDetailViewModel(
            service: service,
            launch: launch,
            launchId: nil
        )
        return viewModel
    }

    func buildSortViewModel(sort: Sort) -> SortViewModel {
        let viewModel = SortViewModel(
            sort: sort
        ) { [weak self] sort in
            self?.sort = sort
            self?.dismiss()
        }
        return viewModel
    }

    // MARK: - Navigation
    func navigateToDetail(launch: Launch) {
        navigationPath.append(.detail(buildLaunchDetailViewModel(launch: launch)))
    }

    func presentSort() {
        presentationItem = .sort(buildSortViewModel(sort: sort))
    }

    func dismiss() {
        presentationItem = nil
    }
}

// MARK: - Navigation
extension MainFlowViewModel {
    enum Navigation: Hashable {
        case detail(LaunchDetailViewModel)
    }
}

// MARK: - Presentation
extension MainFlowViewModel {
    enum Presentation: Presentable {
        case sort(SortViewModel)
    }
}
