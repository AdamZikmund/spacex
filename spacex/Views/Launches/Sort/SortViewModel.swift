import Foundation
import Model

@MainActor final class SortViewModel: ObservableObject {
    typealias OnApply = (Sort) -> Void

    // MARK: - Properties
    @Published var key: String
    @Published var direction: Sort.Direction
    @Published var language: Language

    private let service: Service
    private let onApply: OnApply

    var keyTitle: String {
        L.SortView.key(language)
    }

    var directionTitle: String {
        L.SortView.direction(language)
    }

    var directions: [Sort.Direction] {
        Sort.Direction.allCases
    }

    var applyTitle: String {
        L.SortView.apply(language)
    }

    // MARK: - Lifecycle
    init(
        service: Service,
        sort: Sort,
        onApply: @escaping OnApply
    ) {
        self.service = service
        self.key = sort.key
        self.direction = sort.direction
        self.language = service.appState.language
        self.onApply = onApply
        self.setupBindings()
    }

    // MARK: - Private
    private func setupBindings() {
        service
            .appState
            .publisher
            .dropFirst()
            .map(\.language)
            .removeDuplicates()
            .assign(to: &$language)
    }

    // MARK: - Internal
    func apply() {
        onApply(.init(key: key, direction: direction))
    }

    func directionTitle(for direction: Sort.Direction) -> String {
        switch direction {
        case .asc:
            return L.Common.aSC(language)
        case .desc:
            return L.Common.dESC(language)
        }
    }
}
