import Foundation
import DependencyInjection
import Networking
import Store
import Repository
import Model

struct ErrorService: Service {
    // MARK: - Properties
    let appState: AppStateService
    let launches: LaunchesService

    // MARK: - Private
    private static func buildContainer() -> Container {
        let container = Container()
        container.register(Configuration.self) { _ in
            ConfigurationBuilder.build()
        }
        container.register(Error.self) { _ in
            GeneralError.failure
        }
        container.register(Networking.self) { resolver in
            ErrorNetworking(error: resolver.resolve())
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
