import Foundation
import UIKit
import Model
import Combine

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

    private var launches: [Launch] {
        launchesPaginable.values
    }

    private var searchText: String? {
        searchTextSubject.value
    }

    private var sort: Sort? {
        service.appStateService.get().sort
    }

    var updatePublisher: AnyPublisher<Void, Never> {
        launchesSubject
            .map { _ in }
            .eraseToAnyPublisher()
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
            .appStateService
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
                let query = try await service.launchesService.getLaunches(
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

// MARK: - UITableViewDelegate & UITableViewDataSource
extension LaunchesViewModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        launches.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? LaunchCell, let launch = launches[safe: indexPath.row] {
            cell.update(launch: launch)
        }
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let launch = launches[safe: indexPath.row] {
            openDetail(launch: launch)
        }
    }
}

// MARK: - UISearchBarDelegate
extension LaunchesViewModel: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        if searchText.isEmpty {
            searchTextSubject.send(nil)
        } else {
            searchTextSubject.send(searchText)
        }
    }
}
