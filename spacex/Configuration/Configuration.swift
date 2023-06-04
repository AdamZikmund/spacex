import Foundation

protocol Configuration {
    var baseURL: String { get }
    var headers: [String: String] { get }

    static func build() -> Configuration
}

struct ConfigurationBuilder: Configuration {
    // MARK: - Properties
    var baseURL: String { fatalError("") }
    var headers: [String : String] { fatalError("") }
}
