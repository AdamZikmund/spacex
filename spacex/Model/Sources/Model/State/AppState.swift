import Foundation

public struct AppState: Equatable, Codable {
    // MARK: - Properties
    public var sort: Sort?

    // MARK: - Lifecycle
    public init(sort: Sort? = nil) {
        self.sort = sort
    }
}
