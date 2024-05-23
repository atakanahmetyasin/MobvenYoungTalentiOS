import SwiftUI

struct AllMovieImagesView: View {
    @StateObject var viewModel = MovieImagesViewModel()
    let movieID: Int
    var body: some View {
        NavigationStack {
            VStack {
                Color.black.opacity(0.04)
                    .frame(width: UIScreen.main.bounds.width, height: 3)
                List(viewModel.imagesResult, id: \.id) { image in
                    VStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(image.filePath ?? "")")) { image in
                            image
                                .resizable()
                        } placeholder: {
                            CircularProgressIndicator()
                        }.frame(width: 340, height: 224)
                            .padding(.horizontal, 18)
                    }
                }
                .padding(.top, -50)
                .task {
                    await viewModel.fetchMovieImages(movieID: movieID)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Photos")
                            .padding(.leading, 125)
                    }
                }
                .customBackButton()
            }
            .background(Color("AdaptiveBgColor"))
        }
    }
}

#Preview {
    AllMovieImagesView(movieID: 238)
}
