import Foundation

struct MockConfiguration: Configuration {
    // MARK: - Properties
    var baseURL: String {
        "https://api.spacexdata.com/v4"
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
