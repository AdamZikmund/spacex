import Foundation
import UIKit
import SwiftUI

struct ColorPallete {
    static var background: UIColor { UIColor(named: "background") ?? .clear }
    static var primary: UIColor { UIColor(named: "primary") ?? .clear }
    static var secondary: UIColor { UIColor(named: "secondary") ?? .clear }
    static var tint: UIColor { UIColor(named: "tint") ?? .clear }
    static var title: UIColor { UIColor(named: "title") ?? .clear }
}

extension UIColor {
    var color: Color {
        Color(uiColor: self)
    }
}
