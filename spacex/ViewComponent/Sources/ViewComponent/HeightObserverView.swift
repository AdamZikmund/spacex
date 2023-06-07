import Foundation
import SwiftUI

public struct HeightObserverView<Content: View>: View {
    // MARK: - Properties
    @State private var height: CGFloat
    @ViewBuilder private let content: (CGFloat) -> Content

    // MARK: - Lifecycle
    public init(
        @ViewBuilder content: @escaping (CGFloat) -> Content
    ) {
        self.height = .zero
        self.content = content
    }

    // MARK: - Body
    public var body: some View {
        content(height)
            .background(
                GeometryReader { proxy in
                    Color
                        .clear
                        .preference(key: PreferenceKey.self, value: proxy.size.height)
                }
            )
            .onPreferenceChange(PreferenceKey.self) { height in
                self.height = height
            }
    }
}

// MARK: - PreferenceKey
private struct PreferenceKey: SwiftUI.PreferenceKey {
    static var defaultValue: CGFloat { .zero }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

// MARK: - Preview
struct HeightObserverView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HeightObserverView { height in
                VStack {
                    Text("Height: \(height)")
                }
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
