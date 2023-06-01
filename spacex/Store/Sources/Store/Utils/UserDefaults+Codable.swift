import Foundation

extension UserDefaults {
    func setEncodable<T: Encodable>(_ encodable: T, forKey key: String) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(encodable)
        set(data, forKey: key)
    }

    func getDecodable<T: Decodable>(forKey key: String) throws -> T? {
        let decoder = JSONDecoder()
        if let data = data(forKey: key) {
            return try decoder.decode(T.self, from: data)
        } else {
            return nil
        }
    }
}
