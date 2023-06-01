import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queries: [String: String] { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
}

// MARK: - Default implementation
public extension Endpoint {
    var path: String { "" }
    var method: HTTPMethod { .GET }
    var queries: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
}
