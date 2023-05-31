import Foundation

public struct Launchpad: Decodable {
    // MARK: - Properties
    public let name: String
    public let date: Date
    public let success: Bool?
    public let links: Links
    public let details: String?
    public let crew: [Crew]

    // MARK: - Lifecycle
    public init(
        name: String,
        date: Date,
        success: Bool?,
        links: Links,
        details: String?,
        crew: [Crew]
    ) {
        self.name = name
        self.date = date
        self.success = success
        self.links = links
        self.details = details
        self.crew = crew
    }
}

// MARK: - CodingKeys
private extension Launchpad {
    enum CodingKeys: String, CodingKey {
        case name
        case date = "date_local"
        case success
        case links
        case details
        case crew
    }
}
