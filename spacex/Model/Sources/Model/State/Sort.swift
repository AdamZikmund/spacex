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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let key = container.allKeys.first {
            self.key = key.stringValue
            self.direction = try container.decode(Direction.self, forKey: key)
        } else {
            throw CodableError.decodingFailed
        }
    }

    // MARK: - Codable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let key = CodingKeys(stringValue: key) {
            try container.encodeIfPresent(direction.rawValue, forKey: key)
        }
    }
}

// MARK: - Direction
public extension Sort {
    enum Direction: String, Codable, CaseIterable {
        case asc
        case desc
    }
}

// MARK: - CodingKeys
private extension Sort {
    struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            nil
        }
    }
}
