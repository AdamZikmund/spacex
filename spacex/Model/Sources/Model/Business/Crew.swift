import Foundation

public struct Crew: Decodable {
    // MARK: - Properties
    public let crew: UUID?
    public let role: String?

    // MARK: - Lifecycle
    public init(
        crew: UUID?,
        role: String?
    ) {
        self.crew = crew
        self.role = role
    }
}
