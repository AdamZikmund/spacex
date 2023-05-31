import Foundation
import Model

public struct LanuchesQueryEndpoint: Endpoint {
    // MARK: - Properties
    private let queryBody: QueryBody

    public var path: String {
        "/launches/query"
    }

    public var method: HTTPMethod {
        .POST
    }

    public var body: Encodable? {
        queryBody
    }

    // MARK: - Lifecycle
    public init(queryBody: QueryBody) {
        self.queryBody = queryBody
    }
}
