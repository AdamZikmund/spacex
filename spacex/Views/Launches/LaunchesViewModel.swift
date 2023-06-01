import Foundation
import UIKit
import Model
import Combine

class LaunchesViewModel: NSObject {
    typealias ShowSort = () -> Void
    typealias ShowDetail = (Launch) -> Void
    typealias ShowError = (Error, @escaping () -> Void) -> Void

    // MARK: - Properties
    private let service: Service
    private var store = Set<AnyCancellable>()
    private var offset = 0
    private var hasNextPage = true
    private var isLoading = false
    private let launchesSubject = CurrentValueSubject<[Launch], Never>([])
    private let searchTextSubject = CurrentValueSubject<String?, Never>(nil)

    private let showSort: ShowSort
    private let showDetail: ShowDetail
    private let showError: ShowError

    private var launches: [Launch] {
        launchesSubject.value
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
        !hasNextPage || isLoading
    }

    // MARK: - Lifecycle
    init(
        service: Service,
        showSort: @escaping ShowSort,
        showDetail: @escaping ShowDetail,
        showError: @escaping ShowError
    ) {
        self.service = service
        self.showSort = showSort
        self.showDetail = showDetail
        self.showError = showError
        super.init()
        self.setupBidings()
    }

    // MARK: - Internal
    func reload() {
        launchesSubject.send([])
        offset = .zero
        hasNextPage = true
        getLaunches()
    }

    // MARK: - Navigation
    func openSort() {
        showSort()
    }

    func openDetail(launch: Launch) {
        showDetail(launch)
    }

    func openError(
        error: Error,
        tryAgain: @escaping () -> Void
    ) {
        showError(error, tryAgain)
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
        if !hasNextPage || isLoading { return }
        isLoading = true
        Task(priority: .userInitiated) {
            let result: Result<Query<Launch>, Error>
            do {
                let query = try await service.launchesService.getLaunches(
                    search: searchText,
                    limit: 20,
                    offset: offset,
                    sort: sort
                )
                result = .success(query)
            } catch {
                result = .failure(error)
            }
            await MainActor.run { [weak self] in
                self?.update(result)
            }
        }
    }

    private func update(_ result: Result<Query<Launch>, Error>) {
        switch result {
        case .success(let query):
            launchesSubject.send(launches + query.docs)
            offset = launches.count
            hasNextPage = query.hasNextPage
            isLoading = false
        case .failure(let error):
            self.openError(error: error) { [weak self] in
                self?.reload()
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
