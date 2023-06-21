import Foundation
import DependencyInjection
import Networking
import Repository
import Store

struct LiveService: Service {
    // MARK: - Properties
    let appState: AppStateService
    let launches: LaunchesService

    private static let networkingDelegate = LiveNetworkingDelegate()

    // MARK: - Private
    private static func buildContainer() -> Container {
        let container = Container()
        container.register(Configuration.self) { _ in
            ConfigurationBuilder.build()
        }
        container.register(URLSessionNetworkingDelegate.self) { _ in
            networkingDelegate
        }
        container.register(Networking.self) { resolver in
            let session = URLSession(configuration: .default)
            return URLSessionNetworking(
                session: session,
                delegate: resolver.resolve(URLSessionNetworkingDelegate.self)
            )
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
        container.register(LaunchesRepository.self) { resolver in
            LiveLaunchesRepository(provider: resolver.resolve())
        }
        container.register(AppStateRepository.self) { resolver in
            LiveAppStateRepository(store: resolver.resolve(), state: nil)
        }
        container.register(AppStateService.self) { resolver in
            LiveAppStateService(resolver: resolver)
        }
        container.register(LaunchesService.self) { resolver in
            LiveLaunchesService(resolver: resolver)
        }
        return container
    }

    // MARK: - Service
    static func build() -> Self {
        let container = buildContainer()
        let service = Self.init(
            appState: container.resolve(),
            launches: container.resolve()
        )
        return service
    }
}
