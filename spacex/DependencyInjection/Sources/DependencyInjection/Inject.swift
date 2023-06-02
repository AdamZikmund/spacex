import Foundation

@propertyWrapper public struct Inject<T> {
    // MARK: - Properties
    /// Wrapped value with dependency type
    public var wrappedValue: T

    // MARK: - Lifecycle
    /// Initializes new property with injected dependency
    /// - Parameters:
    ///   - provider: Dependency provider which has container context
    ///   - name: Name of dependency
    public init(
        provider: DependencyProvider = SharedDependencyProvider.shared,
        name: String? = nil
    ) {
        self.wrappedValue = provider.resolver.resolve(T.self, name: name)
    }
}
