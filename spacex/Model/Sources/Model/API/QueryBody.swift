import Foundation

public struct QueryBody: Encodable {
    // MARK: - Properties
    public let query: [String: String]
    public let options: [String: String]

    // MARK: - Lifecycle
    public init(
        query: [String : String],
        options: [String : String]
    ) {
        self.query = query
        self.options = options
    }
}
