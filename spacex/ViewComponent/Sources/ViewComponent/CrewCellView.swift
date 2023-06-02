import Foundation
import SwiftUI

public struct CrewCellView: View {
    // MARK: - Properties
    let title: String?
    let text: String?

    // MARK: - Lifecycle
    public init(title: String?, text: String?) {
        self.title = title
        self.text = text
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.body)
                    .foregroundColor(ColorPallete.primary.color)
            }
            if let text {
                Text(text)
                    .font(.caption)
                    .foregroundColor(ColorPallete.secondary.color)
            }
            Divider()
        }
    }
}

// MARK: - Preview
struct CrewView_Previews: PreviewProvider {
    static var previews: some View {
        CrewCellView(title: UUID().uuidString, text: "Mechanic")
    }
}
