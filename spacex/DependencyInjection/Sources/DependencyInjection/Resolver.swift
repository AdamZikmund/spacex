import Foundation

public struct Resolver {
    // MARK: - Properties
    private let container: Container

    // MARK: - Lifecycle
    /// Initializes resolver for given container
    /// - Parameter container: Dependency container
    init(container: Container) {
        self.container = container
    }

    // MARK: - Public
    /// Resolves dependecy from container
    /// - Parameter type: Dependency type
    /// - Parameter type: Dependency name
    /// - Returns: Dependency
    public func resolve<T>(
        _ type: T.Type,
        name: String? = nil
    ) -> T {
        if let dependency = container.find(type, name: name) {
            return dependency
        } else {
            fatalError("Missing dependency type: \(type), name: \(String(describing: name))")
        }
    }

    /// Impicitly resolves contained dependency
    /// - Parameter type: Dependency type
    /// - Parameter type: Dependency name
    /// - Returns: Dependency
    public func resolve<T>(
        name: String? = nil
    ) -> T {
        return resolve(T.self, name: name)
    }
}
