import Foundation

public class URLSessionNetworking: Networking {
    // MARK: - Properties
    private let session: URLSession

    // MARK: - Lifecycle
    public init(session: URLSession) {
        self.session = session
    }
}

// MARK: - Networking
public extension URLSessionNetworking {
    func request(request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else { return }
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let data, let response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: NetworkingError.invalidResponse)
                }
            }
            task.resume()
        }
    }
}
