import Foundation

public struct QueryBody: Encodable {
    // MARK: - Properties
    public let query: Query
    public let options: Options

    // MARK: - Lifecycle
    public init(
        query: Query = .init(),
        options: Options = .init()
    ) {
        self.query = query
        self.options = options
    }
}

// MARK: - Query
public extension QueryBody {
    struct Query: Encodable {
        public let text: Text?

        public init(text: Text? = nil) {
            self.text = text
        }
    }
}

private extension QueryBody.Query {
    enum CodingKeys: String, CodingKey {
        case text = "$text"
    }
}

public extension QueryBody.Query {
    struct Text: Encodable {
        public let search: String

        public init(search: String) {
            self.search = search
        }
    }
}

private extension QueryBody.Query.Text {
    enum CodingKeys: String, CodingKey {
        case search = "$search"
    }
}

// MARK: - Options
public extension QueryBody {
    struct Options: Encodable {
        public let limit: Int?
        public let offset: Int?
        public let sort: Sort?

        public init(
            limit: Int? = nil,
            offset: Int? = nil,
            sort: Sort? = nil
        ) {
            self.limit = limit
            self.offset = offset
            self.sort = sort
        }
    }
}
