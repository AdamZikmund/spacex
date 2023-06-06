import Foundation
import Model
import ViewComponent

extension Loadable {
    var viewState: ViewState {
        switch self {
        case .loading:
            return .loading
        case .success:
            return .success
        case .failure:
            return .failure
        }
    }
}
