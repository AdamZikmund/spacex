import XCTest
@testable import mock

private enum Presentation: Presentable {
    case detail
    case info(String)
    case call(Int)
}

final class PresentableTests: XCTestCase {
    func testPresentableIdentifier() throws {
        let detail = Presentation.detail
        let info = Presentation.info("Information")
        let call = Presentation.call(777666555)
        XCTAssertEqual(detail.id, "detail")
        XCTAssertEqual(info.id, "info")
        XCTAssertEqual(call.id, "call")
    }
}
