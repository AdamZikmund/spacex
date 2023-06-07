import Foundation
import SwiftUI
import Model
import ViewComponent

struct _LaunchesView: View {
    // MARK: - Properties
    @StateObject private var viewModel: _LaunchesViewModel

    // MARK: - Lifecycle
    init(viewModel: _LaunchesViewModel) {
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
        .onAppear {
            viewModel.getLaunches()
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbar
        }
    }

    private var content: some View {
        VStack {
            LazyVStack {
                launches
                    .redacted(if: viewModel.isLoading)
            }
            loadMore
        }
        .animation(.default, value: viewModel.viewState)
        .padding(.vertical, Space.padding1)
    }

    private var launches: some View {
        ForEach(viewModel.launches, id: \.self) { launch in
            ViewComponent.LaunchCell(
                title: launch.name,
                text: ISO8601DateFormatter().string(from: launch.date),
                showDivider: viewModel.launches.last != launch
            )
            .padding(.horizontal, Space.padding1)
            .onTapGesture {
                viewModel.openDetail(launch: launch)
            }
        }
    }

    @ViewBuilder private var loadMore: some View {
        if viewModel.isLoadMoreVisible {
            Button {
                viewModel.getLaunches()
            } label: {
                Text(viewModel.loadMoreTitle)
                    .foregroundColor(ColorPallete.tint.color)
            }
            .padding(Space.padding1)
        }
    }

    private var error: some View {
        ErrorView(
            text: viewModel.errorTitle,
            tryAgainText: viewModel.tryAgainTitle
        ) {
            viewModel.getLaunches()
        }
    }

    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.openSort()
            } label: {
                Image(systemName: "slider.horizontal.3")
            }
        }
    }
}

// MARK: - Preview
struct _LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            _LaunchesView(
                viewModel: .init(
                    service: MockService.build()
                )
            )
            .navigationTitle("Launches")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
