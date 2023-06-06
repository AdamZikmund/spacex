import Foundation

public struct Crew: Decodable, Hashable {
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

// MARK: - Placeholder
public extension Crew {
    static var placeholder: Self {
        .init(
            crew: "placeholder",
            role: "placeholder"
        )
    }
}
