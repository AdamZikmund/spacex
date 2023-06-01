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

    func testPaginable() throws {
        var paginable = Paginable<Int>(limit: 20, state: .ready)
        XCTAssertTrue(paginable.canStart)
        XCTAssertEqual(paginable.offset, 0)
        XCTAssertEqual(paginable.limit, 20)
        paginable.start()
        XCTAssertFalse(paginable.canStart)
        paginable.loaded((0..<20).compactMap { $0 }, hasNext: true)
        XCTAssertTrue(paginable.canStart)
        XCTAssertEqual(paginable.offset, 20)
        XCTAssertEqual(paginable.limit, 20)
        paginable.start()
        paginable.loaded((0..<10).compactMap { $0 }, hasNext: false)
        XCTAssertFalse(paginable.canStart)
        XCTAssertEqual(paginable.offset, 30)
        XCTAssertEqual(paginable.limit, 20)
        paginable.reset()
        XCTAssertTrue(paginable.canStart)
        XCTAssertEqual(paginable.offset, 0)
        XCTAssertEqual(paginable.limit, 20)
        paginable.failed(CodableError.decodingFailed)
        XCTAssertTrue(paginable.canStart)
        XCTAssertEqual(paginable.offset, 0)
        XCTAssertEqual(paginable.limit, 20)
    }
}
