import Foundation

public struct Crew: Decodable {
    // MARK: - Properties
    public let crew: String?
    public let role: String?

    // MARK: - Lifecycle
    public init(
        crew: String?,
        role: String?
    ) {
        self.crew = crew
        self.role = role
    }
}
