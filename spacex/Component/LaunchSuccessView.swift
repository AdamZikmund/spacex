import Foundation
import SwiftUI

struct LaunchSuccessView: View {
    // MARK: - Properties
    let success: Bool

    // MARK: - Body
    var body: some View {
        if success {
            Text("🚀")
                .font(.system(size: 100))
        } else {
            Text("💥")
                .font(.system(size: 100))
        }
    }
}

// MARK: - Preview
struct LaunchSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchSuccessView(success: true)
            LaunchSuccessView(success: false)
        }
    }
}
