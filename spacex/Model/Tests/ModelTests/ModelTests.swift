import XCTest
@testable import Model

final class ModelTests: XCTestCase {
    func testLoadable() throws {
        var loadable = Loadable<Int>.loading
        XCTAssertNil(loadable.error)
        XCTAssertNil(loadable.value)
        XCTAssertEqual(loadable, .loading)

        loadable = .success(10)
        XCTAssertNil(loadable.error)
        XCTAssertEqual(loadable.value, 10)
        XCTAssertEqual(loadable, .success(10))

        let error = CodableError.decodingFailed
        loadable = .failure(error)
        XCTAssertNotNil(loadable.error)
        XCTAssertNil(loadable.value)
        XCTAssertEqual(loadable, .failure(error))
    }
}
