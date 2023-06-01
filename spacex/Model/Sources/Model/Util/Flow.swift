import Foundation
import UIKit

public protocol Flow {
    var navigationController: UINavigationController { get }

    func start()
}
