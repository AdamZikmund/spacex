import Foundation
import UIKit

extension UIColor {
    static func named(_ name: String) -> UIColor {
        UIColor(named: name, in: Bundle.module, compatibleWith: nil) ?? .clear
    }
}
