import Foundation

public struct SharedDependencyProvider: DependencyProvider {
    // MARK: - Properties
    /// Singleton provider
    public static let shared = Self()
    
    /// Shared container
    public var container = Container()
    
    /// Shared container resolver
    public var resolver: Resolver {
        container.resolver
    }
    
    // MARK: - Lifecycle
    /// Private initializer
    private init() {}
}
