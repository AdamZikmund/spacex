import Foundation
import Model

@MainActor final class SortViewModel: ObservableObject {
    typealias OnApply = (Sort) -> Void

    // MARK: - Properties
    @Published var key: String
    @Published var direction: Sort.Direction

    private let onApply: OnApply

    var keyTitle: String {
        "SortView.Key".localized()
    }

    var directionTitle: String {
        "SortView.Direction".localized()
    }

    var directions: [Sort.Direction] {
        Sort.Direction.allCases
    }

    var applyTitle: String {
        "SortView.Apply".localized()
    }

    // MARK: - Lifecycle
    init(sort: Sort, onApply: @escaping OnApply) {
        self.key = sort.key
        self.direction = sort.direction
        self.onApply = onApply
    }

    // MARK: - Internal
    func apply() {
        onApply(.init(key: key, direction: direction))
    }

    func directionTitle(for direction: Sort.Direction) -> String {
        switch direction {
        case .asc:
            return "Common.ASC".localized()
        case .desc:
            return "Common.DESC".localized()
        }
    }
}
