import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    var preview: some View {
        UIViewControllerRepresentable(controller: self)
    }
}
