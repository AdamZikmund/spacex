import Foundation
import SwiftUI

extension View {
    @ViewBuilder func redacted(
        if condition: @autoclosure () -> Bool = true
    ) -> some View {
        if condition() {
            redacted(reason: .placeholder)
                .allowsHitTesting(false)
        } else {
            self
        }
    }
}
