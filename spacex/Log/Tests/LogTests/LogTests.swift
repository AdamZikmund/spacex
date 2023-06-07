import XCTest
@testable import Log

final class LogTests: XCTestCase {
    func testLogEnabledForDebug() throws {
        Log.shared.level = .debug
        let message = Log.debug("debug")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForDebug() throws {
        Log.shared.level = .info
        let message = Log.debug("debug")
        XCTAssertNil(message)
    }

    func testLogEnabledForInfo() throws {
        Log.shared.level = .info
        let message = Log.info("info")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForInfo() throws {
        Log.shared.level = .verbose
        let message = Log.info("info")
        XCTAssertNil(message)
    }

    func testLogEnabledForVerbose() throws {
        Log.shared.level = .verbose
        let message = Log.verbose("verbose")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForVerbose() throws {
        Log.shared.level = .warning
        let message = Log.verbose("verbose")
        XCTAssertNil(message)
    }

    func testLogEnabledForWarning() throws {
        Log.shared.level = .warning
        let message = Log.warning("warning")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForWarning() throws {
        Log.shared.level = .severe
        let message = Log.warning("warning")
        XCTAssertNil(message)
    }

    func testLogEnabledForSevere() throws {
        Log.shared.level = .severe
        let message = Log.severe("severe")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForSevere() throws {
        Log.shared.level = .error
        let message = Log.severe("severe")
        XCTAssertNil(message)
    }

    func testLogEnabledForError() throws {
        Log.shared.level = .error
        let message = Log.error("error")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForError() throws {
        Log.shared.level = .none
        let message = Log.error("error")
        XCTAssertNil(message)
    }
}
