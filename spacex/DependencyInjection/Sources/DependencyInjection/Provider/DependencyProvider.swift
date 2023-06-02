import Foundation

public protocol DependencyProvider {
    var resolver: Resolver { get }
}
