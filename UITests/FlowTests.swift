import XCTest
@testable import mock

final class UITestsLaunchTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        app = XCUIApplication()
    }

    func testLaunch() throws {
        app.launch()
        let table = app.tables["table"]
        table.descendants(matching: .cell).firstMatch.tap()
        XCTAssertEqual(app.scrollViews.otherElements.staticTexts["Crew"].label, "Crew")
    }
}
