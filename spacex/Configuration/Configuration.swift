import Foundation

protocol Configuration {
    var baseURL: String { get }
    var headers: [String: String] { get }
}
