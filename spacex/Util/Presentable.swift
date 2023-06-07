import Foundation

protocol Presentable: Identifiable {}

extension Presentable {
    var id: String {
        String(describing: self)
            .components(separatedBy: "(")
            .first ?? ""
    }
}
