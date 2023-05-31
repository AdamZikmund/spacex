import Foundation

struct LiveConfiguration: Configuration {
    // MARK: - Properties
    var baseURL: String {
        "https://api.spacexdata.com/v5"
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
