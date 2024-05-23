import SwiftUI

struct MovieImagesView<Model>: View where Model: MovieImagesViewModelProtocol {
    @StateObject var viewModel: Model
    var movieID: Int
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Photos")
                        .font(.system(size: 18))
                        .foregroundStyle(Color("AdaptiveColor"))
                    Spacer()
                    NavigationLink("View All") {
                        AllMovieImagesView(movieID: movieID)
                    }.foregroundStyle(Color(red: 71/255, green: 207/255, blue: 255/255, opacity: 1))
                        .font(.system(size: 14))
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.imagesResult.prefix(10), id: \.id) { image in
                            MovieImagesPageView(movieImages: image)
                                .frame(width: 108, height: 78)
                        }
                    }
                }.task {
                    await viewModel.fetchMovieImages(movieID: movieID)
                }
            }
        }
    }
}

struct MovieImagesPageView: View {
    var movieImages: Backdrop
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movieImages.filePath ?? "")")) { image in
            image
                .resizable()
                .frame(width: 108, height: 72)
                .aspectRatio(contentMode: .fill)
        }
    placeholder: {
        CircularProgressIndicator()
    }
    }
}

#Preview {
    MovieImagesView(viewModel: MovieImagesViewModel(), movieID: 238)
}
