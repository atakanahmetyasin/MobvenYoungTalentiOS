import SwiftUI
import SwiftData

struct ZStackView: View {
    @State private var isFavoriteButtonTapped: Bool
    @Environment(\.dismiss) var dismiss
    var movieID: Int
    let imageURL: String
    @StateObject var viewModel = DetailScreenViewModel()
    @EnvironmentObject var dataViewModel: SwiftDataViewModel
    init(movieID: Int, imageURL: String) {
        self.movieID = movieID
        self.imageURL = imageURL
        _isFavoriteButtonTapped = State(initialValue: UserDefaults.standard.bool(forKey: "isFavorite_\(movieID)"))
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ZStack(alignment: .top) {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .frame(width: geometry.size.width, height: 267)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        CircularProgressIndicator()
                    }
                    Color.black.opacity(0.2)
                        .frame(width: geometry.size.width, height: 267)
                }
                .padding(.top, -60)
                NavigationLink {
                    MovieVideosView(movieID: movieID)
                } label: {
                    ZStack {
                        Color.white.opacity(0.2)
                            .frame(width: 56, height: 56)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white.opacity(1))
                    }
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 00, trailing: 00))
                }
                //
                Button {
                    isFavoriteButtonTapped.toggle()
                    UserDefaults.standard.set(isFavoriteButtonTapped, forKey: "isFavorite_\(movieID)")
                    if isFavoriteButtonTapped {
                        dataViewModel.appendMovie(movieID: viewModel.detailResult?.id ?? 0,
                                                  imageURL: viewModel.detailResult?.posterPath ?? "",
                                                  movieName: viewModel.detailResult?.originalTitle ?? "",
                                                  rating: viewModel.detailResult?.voteAverage ?? 0.0,
                                                  genre: viewModel.detailResult?.genres?.first?.name ?? "",
                                                  duration: String(viewModel.detailResult?.runtime ?? 123))
                    } else {
                        if let movieID = viewModel.detailResult?.id {
                            if let index = dataViewModel.movies.firstIndex(where: { $0.movieID == movieID }) {
                                dataViewModel.removeItem(at: index)
                            } else {
                                print("Movie was not found in the list.")
                            }
                        }
                    }
                } label: {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(isFavoriteButtonTapped ? .red : .white)
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 22))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .padding()
                        .frame(width: geometry.size.width / 2, height: 250)
                        .foregroundStyle(.red)
                        .offset(x: 0, y: geometry.size.height / 3 - 30)
                } placeholder: {
                    CircularProgressIndicator()
                }
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 21)
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: 16, leading: 18, bottom: 0, trailing: 0))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .task {
            await viewModel.getMoviesDetail(movieID: movieID)
        }
    }
}

#Preview {
    ZStackView(movieID: 238, imageURL: "https://image.tmdb.org/t/p/w500/5o8whyfLBWXLODEcMP8K45lPTjT.jpg")
        .environmentObject(SwiftDataViewModel())
}
