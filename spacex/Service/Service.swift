import Foundation
import Networking
import Repository
import Store
import DependencyInjection

struct Service {
    // MARK: - Properties
    let appStateService: AppStateService
    let launchesService: LaunchesService

    // MARK: - Static
    private static func buildLiveService(resolver: Resolver) -> Service {
        Service(
            appStateService: LiveAppStateService(resolver: resolver),
            launchesService: LiveLaunchesService(resolver: resolver)
        )
    }

    private static func buildMockService(resolver: Resolver) -> Service {
        Service(
            appStateService: MockAppStateService(),
            launchesService: MockLaunchesService()
        )
    }

    static func buildLiveService() -> Service {
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
                networking: resolver.resolve(Networking.self),
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
            LiveLaunchesRepository(provider: resolver.resolve(NetworkingProvider.self))
        }
        container.register(AppStateRepository.self) { resolver in
            LiveAppStateRepository(store: resolver.resolve(Store.self), state: nil)
        }
        return buildLiveService(resolver: container.resolver)
    }

    static func buildMockService() -> Service {
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
                networking: resolver.resolve(Networking.self),
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
        return buildMockService(resolver: container.resolver)
    }
}
