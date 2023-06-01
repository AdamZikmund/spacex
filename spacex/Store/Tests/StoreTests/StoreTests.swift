import XCTest
@testable import Store

private struct TestCodable: Codable, Equatable {
    let text: String
    let number: Int
    let data: Data
    let date: Date
}

final class StoreTests: XCTestCase {
    func testSimpleUserDefaultsStore() throws {
        let store = UserDefaultsStore(userDefaults: .standard)
        try store.store("Elon Musk is GOAT", forKey: "key")
        let value: String? = try store.pick(forKey: "key")
        XCTAssertNotNil(value)
        XCTAssertEqual(value, "Elon Musk is GOAT")
    }

    func testCodableUserDefaultsStore() throws {
        let test = TestCodable(text: "Hi", number: 17, data: Data(), date: .now)
        let store = UserDefaultsStore(userDefaults: .standard)
        try store.store(test, forKey: "key")
        let value: TestCodable? = try store.pick(forKey: "key")
        XCTAssertNotNil(value)
        XCTAssertEqual(value, test)
    }
}
