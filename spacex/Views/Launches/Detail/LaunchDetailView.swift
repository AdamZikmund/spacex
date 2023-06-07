import SwiftUI
import ViewComponent
import DependencyInjection

struct LaunchDetailView: View {
    // MARK: - Properties
    @StateObject private var viewModel: LaunchDetailViewModel

    // MARK: - Lifecycle
    init(viewModel: LaunchDetailViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
            switch viewModel.viewState {
            case .loading, .success:
                content
            case .failure:
                error
            }
        }
        .redacted(if: viewModel.isLoading)
        .animation(.default, value: viewModel.viewState)
        .background(ColorPallete.background.color)
        .onAppear {
            viewModel.getLaunch()
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: Space.padding2) {
            header
            details
            crew
            HStack {
                Spacer()
                date
            }
            HStack {
                Spacer()
                success
                Spacer()
            }
            Spacer()
        }
        .padding(.vertical, Space.padding2)
        .padding(.horizontal, Space.padding1)
    }

    private var error: some View {
        ErrorView(
            text: viewModel.errorTitle,
            tryAgainText: viewModel.tryAgainTitle
        ) {
            viewModel.getLaunch()
        }
        .frame(maxWidth: .infinity)
    }

    private var header: some View {
        HStack(alignment: .center) {
            patch
            name
            Spacer()
        }
    }

    private var patch: some View {
        CircleImageView(imageURL: viewModel.patchURL)
            .frame(width: 60, height: 60)
    }

    private var name: some View {
        Text(viewModel.name)
            .font(.largeTitle)
            .foregroundColor(ColorPallete.primary.color)
    }

    private var details: some View {
        Text(viewModel.details)
            .font(.callout)
            .italic()
            .foregroundColor(ColorPallete.primary.color)
    }

    @ViewBuilder private var crew: some View {
        if !viewModel.crew.isEmpty {
            VStack(alignment: .leading) {
                Text("Crew")
                    .font(.title)
                    .foregroundColor(ColorPallete.title.color)
                ForEach(viewModel.crew, id: \.self) { crew in
                    CrewCellView(title: crew.role, text: crew.crew)
                }
            }
        }
    }

    private var date: some View {
        Text(viewModel.date)
            .foregroundColor(ColorPallete.secondary.color)
            .font(.system(.caption))
    }

    private var success: some View {
        LaunchSuccessView(success: viewModel.success)
    }
}

// MARK: - Preview
struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            LaunchDetailView(
                viewModel: .init(
                    service: MockService.build(),
                    launch: nil,
                    launchId: ""
                )
            )
        }
    }
}
