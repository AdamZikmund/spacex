import Foundation
import Model
import DependencyInjection

class LaunchDetailViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var launchLoadable: Loadable<Launch>

    private let service: Service
    private let flow: LaunchesFlow
    private let launchId: String?

    private var launch: Launch? {
        launchLoadable.value
    }

    var isLoading: Bool {
        launchLoadable.isLoading
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
        if isLoading { return (0..<5).map { _ in .init(crew: "placeholder", role: "placeholder") } }
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

    var errorTitle: String {
        "Common.SomethingWentWrong".localized()
    }

    var tryAgain: String {
        "Common.TryAgain".localized()
    }

    // MARK: - Lifecycle
    init(
        service: Service,
        flow: LaunchesFlow,
        launch: Launch?,
        launchId: String?
    ) {
        self.service = service
        self.flow = flow
        self.launchLoadable = .init(value: launch)
        self.launchId = launchId
    }

    // MARK: - Networking
    @discardableResult func getLaunch() -> Task<Void, Never> {
        Task {
            let loadable: Loadable<Launch>
            do {
                guard let launchId else { throw GeneralError.missingData }
                let launch = try await service.launches.getLaunch(id: launchId)
                loadable = .success(launch)
            } catch {
                loadable = .failure(error)
            }
            await MainActor.run { [weak self] in
                self?.launchLoadable = loadable
            }
        }
    }
}
