import Foundation

public class URLSessionNetworking: Networking {
    // MARK: - Properties
    public weak var delegate: NetworkingDelegate?
    private let session: URLSession

    // MARK: - Lifecycle
    public init(
        session: URLSession,
        delegate: NetworkingDelegate? = nil
    ) {
        self.session = session
        self.delegate = delegate
    }
}

// MARK: - Networking
public extension URLSessionNetworking {
    func request(request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self else { return }
            let uuid = UUID()
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                    self.delegate?.networking(self, didReceiveError: error, withUUID: uuid)
                } else if let data, let response {
                    continuation.resume(returning: (data, response))
                    self.delegate?.networking(self, didReceiveData: data, withResponse: response, andUUID: uuid)
                } else {
                    continuation.resume(throwing: NetworkingError.invalidResponse)
                    self.delegate?.networking(self, didReceiveError: NetworkingError.invalidResponse, withUUID: uuid)
                }
            }
            task.resume()
            self.delegate?.networking(self, didSendRequest: request, withUUID: uuid)
        }
    }
}
