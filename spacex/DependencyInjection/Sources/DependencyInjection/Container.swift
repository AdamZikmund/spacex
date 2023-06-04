import Foundation

public class Container {
    // MARK: - Properties
    /// Map for resolving dependencies
    private var dependencies = [String: [String: Any]]()

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
    ///   - name: Optional dependency name
    ///   - resolve: Resolver callback
    public func register<T>(
        _ type: T.Type,
        name dependencyName: String? = nil,
        resolve: (Resolver) -> T
    ) {
        let typeName = String(describing: type)
        let name = dependencyName ?? typeName
        var dependency = dependencies[typeName] ?? [:]
        dependency[name] = resolve(.init(container: self))
        dependencies[typeName] = dependency
    }

    /// Resolves contained dependency
    /// - Parameter type: Type of contained dependency
    /// - Parameter name: Optional dependency name
    /// - Returns: Resolved dependency
    public func resolve<T>(
        _ type: T.Type,
        name: String? = nil
    ) -> T {
        resolver.resolve(type, name: name)
    }

    /// Impicitly resolves contained dependency
    /// - Parameter name: Optional dependency name
    /// - Returns: Resolved dependency
    public func resolve<T>(name: String? = nil) -> T {
        resolve(T.self, name: name)
    }

    // MARK: - Internal
    /// Finds dependency type in dependencies
    /// - Parameter type: Dependency type
    /// - Parameter name: Optional dependency name
    /// - Returns: Stored dependency
    func find<T>(
        _ type: T.Type,
        name dependencyName: String? = nil
    ) -> T? {
        let typeName = String(describing: type)
        let name = dependencyName ?? typeName
        let dependency = dependencies[typeName]
        return dependency?[name] as? T
    }
}
