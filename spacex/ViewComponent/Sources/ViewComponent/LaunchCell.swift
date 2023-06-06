import Foundation
import SwiftUI

public struct LaunchCell: View {
    // MARK: - Properties
    let title: String
    let text: String
    let showDisclosure: Bool
    let showDivider: Bool

    // MARK: - Properties
    public init(
        title: String,
        text: String,
        showDisclosure: Bool = true,
        showDivider: Bool = true
    ) {
        self.title = title
        self.text = text
        self.showDisclosure = showDisclosure
        self.showDivider = showDivider
    }

    // MARK: - Body
    public var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(ColorPallete.title.color)
                    Text(text)
                        .font(.caption)
                        .foregroundColor(ColorPallete.secondary.color)
                }
                Spacer()
                if showDisclosure {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(ColorPallete.tint.color)
                }
            }
            if showDivider {
                Divider()
            }
        }
    }
}

// MARK: - Preview
struct LaunchCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LaunchCell(
                title: "FalconSat",
                text: "2006-03-24T22:30:00Z"
            )
            LaunchCell(
                title: "DemoSat",
                text: "2007-03-24T22:30:00Z",
                showDisclosure: false
            )
            LaunchCell(
                title: "RatSat",
                text: "2008-03-24T22:30:00Z",
                showDivider: false
            )
        }
    }
}
