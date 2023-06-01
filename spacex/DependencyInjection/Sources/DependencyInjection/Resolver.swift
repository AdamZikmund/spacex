import Foundation

public struct Resolver {
    // MARK: - Properties
    private let container: Container

    // MARK: - Lifecycle
    init(container: Container) {
        self.container = container
    }

    // MARK: - Public
    public func resolve<T>(_ type: T.Type) -> T {
        if let dependency = container.find(type) {
            return dependency
        } else {
            fatalError("Missing dependency")
        }
    }
}
