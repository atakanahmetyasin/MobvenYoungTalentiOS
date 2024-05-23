import SwiftUI

struct MovieVideosView: View {
    var movieID: Int
    @StateObject private var viewModel = MovieVideosViewModel()
    var body: some View {
        List(viewModel.resultVideos, id: \.id) { video in
                Video(videoID: video.key ?? "")
                .frame(width: 340, height: 224)
            }
            .task {
                await viewModel.getMovieVideos(movieID: movieID)
            }
    }
}

 #Preview {
     MovieVideosView(movieID: 238)
 }
