import SwiftUI
import SwiftData
struct DetailScreenView<Model>: View where Model: DetailScreenViewModelProtocol {
    @StateObject var viewModel: Model
    @State var movieID: Int
    let imageURL: String
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ZStackView(movieID: movieID, imageURL: imageURL)
                            .frame(width: geometry.size.width, height: geometry.size.height / 3 + 80)
                        MovieDetailView(movieID: movieID)
                            .padding(.top, 16)
                        CastAndCrewView(movieID: movieID)
                        MovieImagesView(viewModel: MovieImagesViewModel(), movieID: movieID)
                            .ignoresSafeArea()
                            .frame(height: 100)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 16)
                    }
                }
                .frame(maxHeight: .infinity)
            }                .background(Color("AdaptiveBgColor"))
        }.toolbar(.hidden)
    }
}

#Preview {
    DetailScreenView(viewModel: DetailScreenViewModel(),
                     movieID: 238,
                     imageURL: "https://image.tmdb.org/t/p/w500/5o8whyfLBWXLODEcMP8K45lPTjT.jpg")
}
