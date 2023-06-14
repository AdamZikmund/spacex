import Foundation
import Model
import Combine

@dynamicMemberLookup protocol AppStateService: AnyObject {
    var publisher: AnyPublisher<AppState, Never> { get }

    func transaction(_ transaction: @escaping (inout AppState) -> Void)

    subscript<Value>(
        dynamicMember keyPath: WritableKeyPath<AppState, Value>
    ) -> Value { get set }
}
