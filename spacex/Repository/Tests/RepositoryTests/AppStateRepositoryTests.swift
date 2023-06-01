import XCTest
@testable import Repository
@testable import Store
@testable import Model

final class AppStateRepositoryTests: XCTestCase {
    private let repository: LiveAppStateRepository = {
        LiveAppStateRepository(
            store: UserDefaultsStore(userDefaults: .standard),
            state: nil
        )
    }()

    func testSimpleValue() throws {
        let newState = AppState(sort: .init(key: "test", direction: .asc))
        repository.set(newState)
        let storedState = repository.getState()
        XCTAssertEqual(newState.sort?.direction, storedState.sort?.direction)
        XCTAssertEqual(newState.sort?.key, storedState.sort?.key)
    }
}
