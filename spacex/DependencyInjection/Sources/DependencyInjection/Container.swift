import Foundation

public class Container {
    // MARK: - Properties
    /// Map for resolving dependencies
    private var dependencies = [String: Any]()

    /// Dependencies resolver
    public var resolver: Resolver {
        .init(container: self)
    }

    // MARK: - Lifecycle
    /// Initializes container
    public init() {}

    // MARK: - Public
    /// Register new dependency to container
    /// - Parameters:
    ///   - type: Type of registered dependency
    ///   - resolve: Resolver callback
    public func register<T>(_ type: T.Type, resolve: (Resolver) -> T) {
        dependencies[String(describing: type)] = resolve(.init(container: self))
    }

    /// Resolves contained dependency
    /// - Parameter type: Type of contained dependency
    /// - Returns: Resolved dependency
    public func resolve<T>(_ type: T.Type) -> T {
        resolver.resolve(type)
    }

    // MARK: - Internal
    /// Finds dependency type in dependencies
    /// - Parameter type: Dependency type
    /// - Returns: Stored dependency
    func find<T>(_ type: T.Type) -> T? {
        dependencies[String(describing: type)] as? T
    }
}
