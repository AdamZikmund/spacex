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

    public mutating func failed(_ error: Error) {
        state = .failed(error)
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
        case failed(Error)
    }
}
