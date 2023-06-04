import Foundation

public protocol DependencyProvider {
    var container: Container { get }
    var resolver: Resolver { get }
}
