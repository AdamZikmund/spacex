import Foundation
import Model
import ViewComponent
import Combine

@MainActor final class _LaunchesViewModel: ObservableObject {
    // MARK: - Properties
    @Published var paginable: Paginable<Launch>
    @Published var searchText = ""
    @Published var language: Language

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
        L.LaunchesViewController.title(language)
    }

    var viewState: ViewState {
        paginable.viewState
    }

    var launches: [Launch] {
        if isLoading { return paginable.values + (0..<5).map { _ in .placeholder }  }
        return paginable.values
    }

    var loadMoreTitle: String {
        L.Common.loadMore(language)
    }

    var errorTitle: String {
        L.Common.somethingWentWrong(language)
    }

    var tryAgainTitle: String {
        L.Common.tryAgain(language)
    }

    var languageEmoji: String {
        switch language {
        case .en:
            return "🇨🇿"
        case .cs:
            return "🇺🇸"
        }
    }

    // MARK: - Lifecycle
    init(service: Service) {
        self.service = service
        self.paginable = .init(limit: 20, state: .ready)
        self.language = service.appState.language
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

        service
            .appState
            .publisher
            .dropFirst()
            .map(\.language)
            .removeDuplicates()
            .assign(to: &$language)
    }

    // MARK: - Internal
    func openDetail(launch: Launch) {
        _navigateToDetail.send(launch)
    }

    func openSort() {
        _navigateToSort.send()
    }

    func toggleLanguage() {
        service.appState.language = language == .cs ? .en : .cs
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
