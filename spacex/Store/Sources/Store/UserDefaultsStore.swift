import Foundation

public class UserDefaultsStore: Store {
    // MARK: - Properties
    private let userDefaults: UserDefaults
    
    // MARK: - Lifecycle
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - Store
    public func store<T: Encodable>(_ value: T, forKey key: String) throws {
        try userDefaults.setEncodable(value, forKey: key)
    }
    
    public func pick<T: Decodable>(forKey key: String) throws -> T? {
        try userDefaults.getDecodable(forKey: key)
    }
}
