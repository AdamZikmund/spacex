import Foundation
import UIKit

struct MockRootFlow: RootFlow {
    var navigationController: UINavigationController = UINavigationController()

    func start() {}
}
