import Foundation

public class Container {
    // MARK: - Properties
    private var dependencies = [String: Any]()

    public var resolver: Resolver {
        .init(container: self)
    }

    // MARK: - Lifecycle
    public init() {}

    // MARK: - Public
    public func register<T>(_ type: T.Type, resolve: (Resolver) -> T) {
        dependencies[String(describing: type)] = resolve(.init(container: self))
    }

    // MARK: - Internal
    func find<T>(_ type: T.Type) -> T? {
        dependencies[String(describing: type)] as? T
    }
}


