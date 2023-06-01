//
//  UITestsLaunchTests.swift
//  UITests
//
//  Created by Adam Zikmund on 01.06.2023.
//

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
    }
}
