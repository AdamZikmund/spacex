import Foundation

public struct Query<T: Decodable>: Decodable {
    // MARK: - Properties
    public let docs: [T]
    public let offset: Int
    public let limit: Int
    public let hasNextPage: Bool

    // MARK: - Lifecycle
    public init(docs: [T], offset: Int, limit: Int, hasNextPage: Bool) {
        self.docs = docs
        self.offset = offset
        self.limit = limit
        self.hasNextPage = hasNextPage
    }
}
