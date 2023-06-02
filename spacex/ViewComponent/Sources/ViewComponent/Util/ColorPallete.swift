import Foundation
import UIKit
import SwiftUI

public struct ColorPallete {
    public static let background: UIColor = .named("background")
    public static let primary: UIColor = .named("primary")
    public static let secondary: UIColor = .named("secondary")
    public static let tint: UIColor = .named("tint")
    public static let title: UIColor = .named("title")
}

public extension UIColor {
    var color: Color {
        Color(uiColor: self)
    }
}
