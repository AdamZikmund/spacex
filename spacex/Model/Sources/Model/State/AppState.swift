import Foundation

public struct AppState: Equatable, Codable {
    // MARK: - Properties
    public var sort: Sort?
    public var language: Language

    // MARK: - Lifecycle
    public init(sort: Sort? = nil, language: Language = .en) {
        self.sort = sort
        self.language = language
    }
}
