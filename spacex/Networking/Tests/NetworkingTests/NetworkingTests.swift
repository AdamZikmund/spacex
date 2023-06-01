import XCTest
@testable import Networking
@testable import Model

private struct TestEndpoint: Endpoint {
    var path: String {
        "/launches"
    }
}

final class NetworkingTests: XCTestCase {
    @MainActor
    func testURLSession() async throws {
        let networking = URLSessionNetworking(session: .shared)
        guard let url = URL(string: "https://google.com") else {
            XCTAssert(true)
            return
        }
        let response = try await networking.request(request: .init(url: url))
        XCTAssertNotNil(response.0)
        XCTAssertNotNil(response.1)
    }

    func testEndpointProvider() async throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let networking = EndpointProvider(
            networking: URLSessionNetworking(session: .shared),
            decoder: decoder,
            encoder: JSONEncoder(),
            baseURL: "https://api.spacexdata.com/v5",
            headers: [:]
        )
        let response: [Launch] = try await networking.sendRequest(to: TestEndpoint())
        XCTAssertNotNil(response)
        XCTAssertFalse(response.isEmpty)
    }
}
