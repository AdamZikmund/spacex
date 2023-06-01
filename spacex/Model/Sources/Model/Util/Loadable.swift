import Foundation

public enum Loadable<T>: Equatable {
    case loading
    case success(T)
    case failure(Error)

    // MARK: - Properties
    public var value: T? {
        if case let .success(value) = self {
            return value
        } else {
            return nil
        }
    }

    public var error: Error? {
        if case let .failure(error) = self {
            return error
        } else {
            return nil
        }
    }

    // MARK: - Lifecycle
    public init(value: T?) {
        if let value {
            self = .success(value)
        } else {
            self = .loading
        }
    }

    // MARK: - Equatable
    public static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}
