import Foundation
import DependencyInjection
import Networking
import Repository
import Store

struct MockService: Service {
    // MARK: - Properties
    let appState: AppStateService
    let launches: LaunchesService

    // MARK: - Private
    private static func buildContainer() -> Container {
        let container = Container()
        container.register(Configuration.self) { _ in
            ConfigurationBuilder.build()
        }
        container.register(Networking.self) { _ in
            let session = URLSession(configuration: .default)
            return URLSessionNetworking(session: session)
        }
        container.register(NetworkingProvider.self) { resolver in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            return EndpointProvider(
                networking: resolver.resolve(),
                decoder: decoder,
                encoder: encoder,
                baseURL: resolver.resolve(Configuration.self).baseURL,
                headers: resolver.resolve(Configuration.self).headers
            )
        }
        container.register(Store.self) { _ in
            UserDefaultsStore(userDefaults: .standard)
        }
        container.register(LaunchesRepository.self) { _ in
            MockLaunchesRepository()
        }
        container.register(AppStateRepository.self) { _ in
            MockAppStateRepository()
        }
        container.register(AppStateService.self) { _ in
            MockAppStateService()
        }
        container.register(LaunchesService.self) { _ in
            MockLaunchesService()
        }
        return container
    }

    // MARK: - Service
    static func build() -> MockService {
        let container = buildContainer()
        let service = Self.init(
            appState: container.resolve(),
            launches: container.resolve()
        )
        return service
    }
}
