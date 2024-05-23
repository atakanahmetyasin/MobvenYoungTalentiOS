import SwiftUI
import SwiftData

struct WatchListView: View {
    @EnvironmentObject var dataViewModel: SwiftDataViewModel
    var body: some View {
        NavigationStack {
            if dataViewModel.movies.count == 0 {
                Text("No Favorite Movie Added")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(dataViewModel.movies, id: \.id) { movie in
                            VStack(alignment: .leading, spacing: 0) {
                                NavigationLink {
                                    DetailScreenView(viewModel: DetailScreenViewModel(), movieID: movie.movieID,
                                                     imageURL: "https://image.tmdb.org/t/p/w500\(movie.imageURL )")
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.imageURL)")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            CircularProgressIndicator()
                                        }
                                        .frame(width: 167, height: 250)
                                        HStack {
                                            let roundedVote = Int(round(movie.rating / 2))
                                            ForEach(1...5, id: \.self) { star in
                                                Image(systemName: star <= roundedVote ? "star.fill" : "star")
                                                    .foregroundColor(.yellow)
                                                    .frame(width: 14, height: 14)
                                            }
                                            .padding(.top, 16)
                                            .frame(width: 14, alignment: .leading)
                                        }
                                        Text(movie.movieName)
                                            .foregroundStyle(Color("AdaptiveColor"))
                                            .multilineTextAlignment(.leading)
                                            .fontWeight(.semibold)
                                            .frame(height: 40)
                                            .font(.custom("SF-Pro-Text", size: 16))
                                        HStack {
                                            Text(movie.genre)
                                            Text("·")
                                            Text(movie.duration)
                                            Text("|")
                                            Text("R")
                                        }
                                        .foregroundStyle(Color("AdaptiveColor").opacity(0.5))
                                        .font(.custom("SF-Pro-Text", size: 12))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .background(Color("AdaptiveBgColor"))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("WatchList")
                            .padding(.leading, 133)
                    }
                }
            }
        }
    }
}

#Preview {
    WatchListView()
        .environmentObject(SwiftDataViewModel())
}
