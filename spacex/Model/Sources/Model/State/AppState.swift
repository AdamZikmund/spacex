import Foundation

public struct AppState: Codable {
    // MARK: - Properties
    public let sort: Sort?

    // MARK: - Lifecycle
    public init(sort: Sort? = nil) {
        self.sort = sort
    }
}
