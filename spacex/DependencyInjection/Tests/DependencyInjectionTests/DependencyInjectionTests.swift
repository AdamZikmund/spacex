import XCTest
@testable import DependencyInjection

final class DependencyInjectionTests: XCTestCase {
    func testDependencies() {
        let container = Container()
        container.register(Int.self) { _ in
            7
        }
        container.register(String.self) { resolver in
            "My favorite number is \(resolver.resolve(Int.self))"
        }
        let text = container.resolve(String.self)
        XCTAssertEqual(text, "My favorite number is 7")
    }
}
