import SwiftUI
struct ReleaseDatesView<Model>: View where Model: ReleaseDatesViewModelProtocol {
    @StateObject var viewModel: Model
    @State var movieID: Int
    var body: some View {
        VStack {
            Text(firstNonEmptyCertification())
        }
    }
    private func firstNonEmptyCertification() -> String {
        for result in viewModel.resultReleaseDates?.results ?? [] {
            if let certification = result.releaseDates?.compactMap({ $0.certification }).first(where: { !$0.isEmpty }) {
                return certification
            }
        }
        return ""
    }
}
