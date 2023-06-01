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
    /// - Returns: Dependency
    public func resolve<T>(_ type: T.Type) -> T {
        if let dependency = container.find(type) {
            return dependency
        } else {
            fatalError("Missing dependency")
        }
    }
}
