import Foundation

public protocol Provider {
    func sendRequest<T: Decodable>(to endpoint: Endpoint) async throws -> T
}
