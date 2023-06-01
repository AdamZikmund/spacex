import Foundation

public class EndpointProvider: NetworkingProvider {
    // MARK: - Properties
    private let networking: Networking
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let baseURL: String
    private let headers: [String: String]

    // MARK: - Lifecycle
    public init(
        networking: Networking,
        decoder: JSONDecoder,
        encoder: JSONEncoder,
        baseURL: String,
        headers: [String: String]
    ) {
        self.networking = networking
        self.decoder = decoder
        self.encoder = encoder
        self.baseURL = baseURL
        self.headers = headers
    }
}

// MARK: - Provider
public extension EndpointProvider {
    func sendRequest<T>(
        to endpoint: Endpoint
    ) async throws -> T where T : Decodable {
        guard let request = try endpoint.buildURLRequest(encoder: encoder, baseURL: baseURL, headers: headers) else {
            throw NetworkingError.invalidEndpoint
        }
        let (data, _) = try await networking.request(request: request)
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: - Endpoint
private extension Endpoint {
    func buildURLRequest(
        encoder: JSONEncoder,
        baseURL: String,
        headers globalHeaders: [String: String]
    ) throws -> URLRequest? {
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.path += path
        if !queries.isEmpty {
            components.queryItems = queries.map { .init(name: $0, value: $1) }
        }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers.merging(globalHeaders) { old, _ in
            old
        }
        if let body {
            request.httpBody = try encoder.encode(body)
        }
        return request
    }
}
