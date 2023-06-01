import Foundation

public protocol Store {
    func store<T: Encodable>(_ value: T, forKey key: String) throws
    func pick<T: Decodable>(forKey key: String) throws -> T?
}
