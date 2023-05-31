import Foundation

public struct Patch: Decodable {
    // MARK: - Properties
    public let small: String?
    public let large: String?

    public var smallURL: URL? {
        guard let small else { return nil }
        return URL(string: small)
    }

    public var largeURL: URL? {
        guard let large else { return nil }
        return URL(string: large)
    }

    // MARK: - Lifecycle
    public init(
        small: String?,
        large: String?
    ) {
        self.small = small
        self.large = large
    }
}
