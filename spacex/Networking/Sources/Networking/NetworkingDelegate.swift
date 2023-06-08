import Foundation

public protocol NetworkingDelegate: AnyObject {
    func networking(
        _ networking: Networking,
        didSendRequest request: URLRequest,
        withUUID uuid: UUID
    )

    func networking(
        _ networking: Networking,
        didReceiveData data: Data,
        withResponse response: URLResponse,
        andUUID uuid: UUID
    )

    func networking(
        _ networking: Networking,
        didReceiveError error: Error,
        withUUID uuid: UUID
    )
}
