import Foundation
import SwiftUI

public struct CircleImageView: View {
    // MARK: - Properties
    let imageURL: URL?

    // MARK: - Lifecycle
    public init(imageURL: URL?) {
        self.imageURL = imageURL
    }

    // MARK: - Body
    public var body: some View {
        AsyncImage(url: imageURL) { content in
            content
                .resizable()
                .scaledToFill()
        } placeholder: {
            ZStack {
                ColorPallete.secondary.color
                ProgressView()
                    .tint(ColorPallete.tint.color)
            }
        }
        .clipShape(Circle())
    }
}

// MARK: - Preview
struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageURL: URL(string: "https://shorturl.at/yISUY"))
    }
}
