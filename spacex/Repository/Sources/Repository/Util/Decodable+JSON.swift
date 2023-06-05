import Foundation

extension Decodable {
    static func loadJSON(
        _ name: String,
        delay: Duration? = nil
    ) async throws -> Self {
        if let delay {
           try await Task.sleep(for: delay)
        }
        guard let url = Bundle.module.url(forResource: name, withExtension: ".json") else {
            throw JSONError.invalidPath
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Self.self, from: data)
    }
}
