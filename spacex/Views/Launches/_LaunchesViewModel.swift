import Foundation
import Model
import ViewComponent
import Combine

@MainActor final class _LaunchesViewModel: ObservableObject {
    // MARK: - Properties
    @Published var paginable: Paginable<Launch>
    @Published var searchText = ""

    private let service: Service
    private var bag = Set<AnyCancellable>()

    private let _navigateToDetail = PassthroughSubject<Launch, Never>()
    private let _navigateToSort = PassthroughSubject<Void, Never>()

    var navigateToDetail: AnyPublisher<Launch, Never> {
        _navigateToDetail.eraseToAnyPublisher()
    }

    var navigateToSort: AnyPublisher<Void, Never> {
        _navigateToSort.eraseToAnyPublisher()
    }

    private var sort: Sort? {
        service.appState.sort
    }

    var isLoading: Bool {
        paginable.isLoading
    }

    var isLoadMoreVisible: Bool {
        paginable.canStart && !isLoading && !paginable.values.isEmpty
    }

    var title: String {
        "LaunchesViewController.Title".localized()
    }

    var viewState: ViewState {
        paginable.viewState
    }

    var launches: [Launch] {
        if isLoading { return paginable.values + (0..<5).map { _ in .placeholder }  }
        return paginable.values
    }

    var loadMoreTitle: String {
        "Common.LoadMore".localized()
    }

    var errorTitle: String {
        "Common.SomethingWentWrong".localized()
    }

    var tryAgainTitle: String {
        "Common.TryAgain".localized()
    }

    // MARK: - Lifecycle
    init(service: Service) {
        self.service = service
        self.paginable = .init(limit: 20, state: .ready)
        self.setupBindings()
    }

    // MARK: - Private
    private func setupBindings() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .dropFirst()
            .removeDuplicates()
            .map { _ in }
            .sink { [weak self] in
                self?.reloadLaunches()
            }
            .store(in: &bag)

        service
            .appState
            .publisher
            .dropFirst()
            .map { _ in }
            .sink { [weak self] in
                self?.reloadLaunches()
            }
            .store(in: &bag)
    }

    // MARK: - Internal
    func openDetail(launch: Launch) {
        _navigateToDetail.send(launch)
    }

    func openSort() {
        _navigateToSort.send()
    }

    // MARK: - Networking
    @discardableResult func getLaunches() -> Task<Void, Never> {
        Task(priority: .userInitiated) {
            guard paginable.canStart else { return }
            paginable.start()
            do {
                let query = try await service.launches.getLaunches(
                    search: searchText,
                    limit: paginable.limit,
                    offset: paginable.offset,
                    sort: sort
                )
                paginable.loaded(query.docs, hasNext: query.hasNextPage)
            } catch {
                paginable.failure(error)
            }
        }
    }

    @discardableResult func reloadLaunches() -> Task<Void, Never> {
        paginable.reset()
        return getLaunches()
    }
}
