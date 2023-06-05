import Foundation
import UIKit
import Model
import Combine
import DependencyInjection

class LaunchesViewModel: NSObject {
    // MARK: - Properties
    private let service: Service
    private let flow: LaunchesFlow
    private var store = Set<AnyCancellable>()
    private let launchesSubject = PassthroughSubject<[Launch], Never>()
    private let searchTextSubject = CurrentValueSubject<String?, Never>(nil)

    private var launchesPaginable: Paginable<Launch> = .init() {
        didSet {
            if case .ready = launchesPaginable.state {
                launchesSubject.send(launches)
            }
        }
    }

    private var searchText: String? {
        searchTextSubject.value
    }

    private var sort: Sort? {
        service.appState.get().sort
    }

    var updatePublisher: AnyPublisher<Void, Never> {
        launchesSubject
            .map { _ in }
            .eraseToAnyPublisher()
    }

    var launches: [Launch] {
        launchesPaginable.values
    }

    var title: String {
        "LaunchesViewController.Title".localized()
    }

    var placeholder: String {
        "Common.Search".localized()
    }

    var loadMore: String {
        "Common.LoadMore".localized()
    }

    var isLoadMoreButtonHidden: Bool {
        !launchesPaginable.canStart
    }

    // MARK: - Lifecycle
    init(
        service: Service,
        flow: LaunchesFlow
    ) {
        self.service = service
        self.flow = flow
        super.init()
        self.setupBidings()
    }

    // MARK: - Internal
    func reload() {
        launchesPaginable.reset()
        getLaunches()
    }

    func setSearchText(_ searchText: String?) {
        searchTextSubject.send(searchText)
    }

    // MARK: - Navigation
    func openSort() {
        flow.showSortSheet()
    }

    func openDetail(launch: Launch) {
        flow.showDetail(launch: launch)
    }

    func openError(
        error: Error,
        tryAgain: @escaping () -> Void
    ) {
        flow.showErrorAlert(error: error, tryAgain: tryAgain)
    }

    // MARK: - Private
    private func setupBidings() {
        service
            .appState
            .appStatePublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { [weak self] _ in
                self?.reload()
            }
            .store(in: &store)

        searchTextSubject
            .debounce(for: 1, scheduler: RunLoop.main)
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { [weak self] _ in
                self?.reload()
            }
            .store(in: &store)
    }

    // MARK: - Networking
    func getLaunches() {
        guard launchesPaginable.canStart else { return }
        launchesPaginable.start()
        Task(priority: .userInitiated) {
            let result: Result<Query<Launch>, Error>
            do {
                let query = try await service.launches.getLaunches(
                    search: searchText,
                    limit: launchesPaginable.limit,
                    offset: launchesPaginable.offset,
                    sort: sort
                )
                result = .success(query)
            } catch {
                result = .failure(error)
            }
            await MainActor.run { [weak self] in
                switch result {
                case .success(let query):
                    self?.launchesPaginable.loaded(query.docs, hasNext: query.hasNextPage)
                case .failure(let error):
                    self?.launchesPaginable.failed(error)
                    self?.openError(error: error) {
                        self?.getLaunches()
                    }
                }
            }
        }
    }
}
