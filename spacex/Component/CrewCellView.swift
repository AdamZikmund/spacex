import Foundation
import SwiftUI
import Model

struct CrewCellView: View {
    // MARK: - Properties
    let crew: Crew

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            if let role = crew.role {
                Text(role)
                    .font(.body)
                    .foregroundColor(ColorPallete.primary.color)
            }
            if let crew = crew.crew {
                Text(crew)
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
        CrewCellView(crew: .init(crew: UUID().uuidString, role: "Mechanic"))
    }
}
