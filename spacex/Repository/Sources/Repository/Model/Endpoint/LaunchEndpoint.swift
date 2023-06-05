import Foundation
import Networking
import Model

public struct LaunchEndpoint: Endpoint {
    // MARK: - Properties
    private let id: String

    public var path: String {
        "/launches/\(id)"
    }

    public var method: HTTPMethod {
        .GET
    }

    // MARK: - Lifecycle
    public init(id: String) {
        self.id = id
    }
}
