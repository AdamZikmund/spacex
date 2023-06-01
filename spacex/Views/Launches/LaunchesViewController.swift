import Foundation
import UIKit
import Combine

class LaunchesViewController: UITableViewController {
    // MARK: - Properties
    private let viewModel: LaunchesViewModel
    private var store = Set<AnyCancellable>()

    // MARK: - Views
    private weak var loadMoreButton: UIButton?

    // MARK: - Lifecycle
    init(viewModel: LaunchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.getLaunches()
    }

    // MARK: - Private
    private func setup() {
        setupTableView()
        setupBindings()
        setupNavigationBar()
    }

    private func setupTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        tableView.refreshControl = refreshControl
        let searchBar = UISearchBar(frame: .init(x: 0, y: 0, width: 0, height: 50))
        searchBar.delegate = viewModel
        searchBar.placeholder = viewModel.placeholder
        tableView.tableHeaderView = searchBar
        let button = UIButton(frame: .zero)
        button.setTitle(viewModel.loadMore, for: .normal)
        button.addTarget(self, action: #selector(onLoadMore), for: .touchUpInside)
        button.sizeToFit()
        button.setTitleColor(.tintColor, for: .normal)
        tableView.tableFooterView = button
        tableView.accessibilityIdentifier = "table"
        loadMoreButton = button
    }

    private func setupBindings() {
        viewModel
            .updatePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.update()
            }
            .store(in: &store)
    }

    private func setupNavigationBar() {
        navigationItem.title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "slider.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(onSortTap)
        )
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "sort"
    }

    private func update() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadSections(.init(integer: 0), with: .automatic)
        loadMoreButton?.isHidden = viewModel.isLoadMoreButtonHidden
    }

    @objc private func refreshControlValueChanged() {
        viewModel.reload()
    }

    @objc private func onSortTap() {
        viewModel.openSort()
    }

    @objc private func onLoadMore() {
        viewModel.getLaunches()
    }
}
