import Foundation

public struct Links: Decodable {
    // MARK: - Properties
    public let patch: Patch

    // MARK: - Lifecycle
    public init(patch: Patch) {
        self.patch = patch
    }
}
