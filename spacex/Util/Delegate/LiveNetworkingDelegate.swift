import Foundation
import Networking
import Log

class LiveNetworkingDelegate: URLSessionNetworkingDelegate {
    func networking(
        _ networking: Networking,
        didSendRequest request: URLRequest,
        withUUID uuid: UUID
    ) {
        let granularities: Set<Granularity> = [.date, .symbol]
        let url = "[\(uuid.uuidString)] URL: \(request.url?.absoluteString ?? "")"
        let method = "[\(uuid.uuidString)] METHOD: \(request.httpMethod ?? "")"
        let headers = "[\(uuid.uuidString)] HEADERS: \(request.allHTTPHeaderFields ?? [:])"
        let body = "[\(uuid.uuidString)] BODY: \(request.httpBodyStream?.utf8String ?? "")"
        Log.debug(url, granularity: granularities)
        Log.debug(method, granularity: granularities)
        Log.debug(headers, granularity: granularities)
        Log.debug(body, granularity: granularities)
    }

    func networking(
        _ networking: Networking,
        didReceiveData data: Data,
        withResponse response: URLResponse,
        andUUID uuid: UUID
    ) {
        guard let response = response as? HTTPURLResponse else { return }
        let granularities: Set<Granularity> = [.date, .symbol]
        let url = "[\(uuid.uuidString)] URL: \(response.url?.absoluteString ?? "")"
        let statusCode = "[\(uuid.uuidString)] STATUS CODE: \(response.statusCode)"
        let headers = "[\(uuid.uuidString)] HEADERS: \(response.allHeaderFields as? [String: String] ?? [:])"
        let body = "[\(uuid.uuidString)] BODY: \(String(data: data, encoding: .utf8) ?? "")"
        Log.debug(url, granularity: granularities)
        Log.debug(statusCode, granularity: granularities)
        Log.debug(headers, granularity: granularities)
        Log.debug(body, granularity: granularities)
    }

    func networking(
        _ networking: Networking,
        didReceiveError error: Error,
        withUUID uuid: UUID
    ) {
        Log.error("[\(uuid.uuidString)] ERROR: \(error)", granularity: [.date, .symbol])
    }
}
