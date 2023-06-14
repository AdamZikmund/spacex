import Foundation
import Model
import DependencyInjection
import ViewComponent

@MainActor final class LaunchDetailViewModel: ObservableObject, Navigable {
    // MARK: - Properties
    @Published var launchLoadable: Loadable<Launch>
    @Published var language: Language

    private let service: Service
    private let launchId: String?

    private var launch: Launch? {
        launchLoadable.value
    }

    var viewState: ViewState {
        launchLoadable.viewState
    }

    var isLoading: Bool {
        launchLoadable.viewState == .loading
    }

    var name: String {
        if isLoading { return "placeholder" }
        return launch?.name ?? ""
    }

    var details: String {
        if isLoading { return "placeholder" }
        return launch?.details ?? ""
    }

    var crew: [Crew] {
        if isLoading { return (0..<5).map { _ in .placeholder } }
        return launch?.crew ?? []
    }

    var success: Bool {
        if isLoading { return true }
        return launch?.success ?? false
    }

    var date: String {
        if isLoading { return "placeholder" }
        if let date = launch?.date {
            return ISO8601DateFormatter().string(from: date)
        } else {
            return ""
        }
    }

    var patchURL: URL? {
        launch?.links.patch.smallURL
    }

    var crewTitle: String {
        L.LaunchDetailView.crew(language)
    }

    var errorTitle: String {
        L.Common.somethingWentWrong(language)
    }

    var tryAgainTitle: String {
        L.Common.tryAgain(language)
    }

    // MARK: - Lifecycle
    init(
        service: Service,
        launch: Launch?,
        launchId: String?
    ) {
        self.service = service
        self.launchLoadable = .init(value: launch)
        self.launchId = launchId
        self.language = service.appState.language
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

    // MARK: - Networking
    @discardableResult func getLaunch() -> Task<Void, Never> {
        Task(priority: .userInitiated) {
            do {
                guard launch == nil else { return }
                guard let launchId else { throw GeneralError.missingData }
                let launch = try await service.launches.getLaunch(id: launchId)
                launchLoadable = .success(launch)
            } catch {
                launchLoadable = .failure(error)
            }
        }
    }
}
