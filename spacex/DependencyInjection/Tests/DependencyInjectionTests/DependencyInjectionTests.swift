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

    func testNamedDependencies() {
        let container = Container()
        container.register(String.self, name: "Dependency1") { _ in
            "Jedi"
        }
        container.register(String.self, name: "Dependency2") { _ in
            "Sith"
        }
        container.register(String.self) { _ in
            "Han Solo"
        }
        let jedi = container.resolve(String.self, name: "Dependency1")
        let sith = container.resolve(String.self, name: "Dependency2")
        let hanSolo = container.resolve(String.self)
        XCTAssertEqual(jedi, "Jedi")
        XCTAssertEqual(sith, "Sith")
        XCTAssertEqual(hanSolo, "Han Solo")
    }
}
