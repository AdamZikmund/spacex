import Foundation

public protocol Networking {
    var delegate: NetworkingDelegate? { get }

    func request(request: URLRequest) async throws -> (Data, URLResponse)
}
