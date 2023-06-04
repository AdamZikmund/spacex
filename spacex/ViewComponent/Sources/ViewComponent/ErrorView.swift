import Foundation
import SwiftUI

public struct ErrorView: View {
    // MARK: - Properties
    let text: String
    let tryAgainText: String
    let tryAgain: () -> Void

    // MARK: - Lifecycle
    public init(
        text: String,
        tryAgainText: String,
        tryAgain: @escaping () -> Void
    ) {
        self.text = text
        self.tryAgainText = tryAgainText
        self.tryAgain = tryAgain
    }

    // MARK: - Body
    public var body: some View {
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
            .padding(Space.padding1)
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
