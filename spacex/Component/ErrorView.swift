import Foundation
import SwiftUI

struct ErrorView: View {
    // MARK: - Properties
    let text: String
    let tryAgainText: String
    let tryAgain: () -> Void

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Text("🥺")

                .font(.system(size: 100))
            Text(text)
                .font(.title)
                .foregroundColor(ColorPallete.secondary.color)
            Button {
                tryAgain()
            } label: {
                Text(tryAgainText)
            }
            .padding(Spacing.padding1)
        }
    }
}

// MARK: - Preview
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            text: "Something went wrong!",
            tryAgainText: "Try again"
        ) {
            print("Try again")
        }
    }
}
