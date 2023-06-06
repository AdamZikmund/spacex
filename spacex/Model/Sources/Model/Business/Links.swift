import Foundation

public struct Links: Decodable, Hashable {
    // MARK: - Properties
    public let patch: Patch

    // MARK: - Lifecycle
    public init(patch: Patch) {
        self.patch = patch
    }
}

// MARK: - Placeholder
public extension Links {
    static var placeholder: Self {
        .init(patch: .placeholder)
    }
}
