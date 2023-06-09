import Foundation

public struct Launch: Decodable, Hashable {
    // MARK: - Properties
    public let id: String
    public let name: String
    public let date: Date
    public let success: Bool?
    public let links: Links
    public let details: String?
    public let crew: [Crew]

    // MARK: - Lifecycle
    public init(
        id: String,
        name: String,
        date: Date,
        success: Bool?,
        links: Links,
        details: String?,
        crew: [Crew]
    ) {
        self.id = id
        self.name = name
        self.date = date
        self.success = success
        self.links = links
        self.details = details
        self.crew = crew
    }
}

// MARK: - CodingKeys
private extension Launch {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date = "date_local"
        case success
        case links
        case details
        case crew
    }
}

// MARK: - Placeholder
public extension Launch {
    static var placeholder: Self {
        .init(
            id: UUID().uuidString,
            name: "placeholder",
            date: .now,
            success: true,
            links: .placeholder,
            details: "placeholder",
            crew: (0..<5).map { _ in .placeholder }
        )
    }
}
