import Foundation
import SwiftUI
import ViewComponent

struct SortView: View {
    // MARK: - Properties
    @StateObject private var viewModel: SortViewModel

    // MARK: - Lifecycle
    init(viewModel: SortViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            key
            Divider()
            direction
            Divider()
            apply
        }
        .padding(.horizontal, Space.padding1)
        .padding(.vertical, Space.padding2)
    }

    private var key: some View {
        HStack {
            Text(viewModel.keyTitle)
            TextField("", text: $viewModel.key)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Spacer()
        }
    }

    private var direction: some View {
        HStack {
            Text(viewModel.directionTitle)
            Picker("", selection: $viewModel.direction) {
                ForEach(viewModel.directions, id: \.self) { direction in
                    Text(viewModel.directionTitle(for: direction))
                }
            }
            Spacer()
        }
    }

    private var apply: some View {
        Button {
            viewModel.apply()
        } label: {
            Text(viewModel.applyTitle)
        }
    }
}

// MARK: - Preview
struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView(
            viewModel: .init(
                service: MockService.build(),
                sort: .init(key: "date_local", direction: .asc),
                onApply: { _ in }
            )
        )
    }
}
