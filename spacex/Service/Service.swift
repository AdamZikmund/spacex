import Foundation
import Networking
import Repository
import Swinject

struct Service {
    // MARK: - Properties
    let appStateService: AppStateService
    let launchesService: LaunchesService

    // MARK: - Static
    private static func buildService(container: Container) -> Service {
        Service(
            appStateService: AppStateService(container: container),
            launchesService: LaunchesService(container: container)
        )
    }

    static func buildLiveService() -> Service {
        let container = Container()
        container.register(Configuration.self) { _ in
            LiveConfiguration()
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
                networking: resolver.resolve(Networking.self)!,
                decoder: decoder,
                encoder: encoder,
                baseURL: resolver.resolve(Configuration.self)!.baseURL,
                headers: resolver.resolve(Configuration.self)!.headers
            )
        }
        container.register(LaunchesRepository.self) { resolver in
            LiveLaunchesRepository(provider: resolver.resolve(NetworkingProvider.self)!)
        }
        container.register(AppStateRepository.self) { _ in
            LiveAppStateRepository(userDefaults: .standard, state: nil)
        }
        return buildService(container: container)
    }

    static func buildMockService() -> Service {
        let container = Container()
        container.register(Configuration.self) { _ in
            MockConfiguration()
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
                networking: resolver.resolve(Networking.self)!,
                decoder: decoder,
                encoder: encoder,
                baseURL: resolver.resolve(Configuration.self)!.baseURL,
                headers: resolver.resolve(Configuration.self)!.headers
            )
        }
        container.register(LaunchesRepository.self) { _ in
            MockLaunchesRepository()
        }
        container.register(AppStateRepository.self) { _ in
            MockAppStateRepository()
        }
        return buildService(container: container)
    }
}
