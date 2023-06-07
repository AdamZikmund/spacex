import Foundation
import Model
import ViewComponent

extension Paginable {
    var viewState: ViewState {
        switch state {
        case .loading:
            return .loading
        case .ready:
            return .success
        case .failure:
            return .failure
        }
    }
}
