import Foundation

public struct Sort: Codable {
    // MARK: - Properties
    public let key: String
    public let direction: Direction

    // MARK: - Lifecycle
    public init(
        key: String,
        direction: Direction
    ) {
        self.key = key
        self.direction = direction
    }
}

// MARK: - Direction
public extension Sort {
    enum Direction: String, Codable {
        case asc
        case desc
    }
}
