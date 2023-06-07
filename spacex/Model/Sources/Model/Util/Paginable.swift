import Foundation

public struct Paginable<T> {
    // MARK: - Properties
    public let limit: Int
    public private(set) var state: State
    public private(set) var values: [T]
    private var hasNext: Bool

    public var offset: Int {
        values.count
    }

    public var canStart: Bool {
        if case .loading = state {
            return false
        } else {
            return hasNext
        }
    }

    public var isLoading: Bool {
        if case .loading = state {
            return true
        } else {
            return false
        }
    }

    public var error: Error? {
        if case let .failure(error) = state {
            return error
        } else {
            return nil
        }
    }

    // MARK: - Lifecycle
    public init(
        limit: Int = 20,
        state: State = .ready
    ) {
        self.limit = limit
        self.state = state
        self.values = []
        self.hasNext = true
    }

    // MARK: - Public
    public mutating func start() {
        state = .loading
    }

    public mutating func loaded(
        _ newValues: [T],
        hasNext next: Bool
    ) {
        values += newValues
        hasNext = next
        state = .ready
    }

    public mutating func failure(_ error: Error) {
        state = .failure(error)
    }

    public mutating func reset() {
        values.removeAll()
        hasNext = true
        state = .ready
    }
}

// MARK: - State
public extension Paginable {
    enum State {
        case loading
        case ready
        case failure(Error)
    }
}
