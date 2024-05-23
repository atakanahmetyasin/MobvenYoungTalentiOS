import SwiftUI

@MainActor final class MovieVideosViewModel: ObservableObject {
    @Published var resultVideos: [ResultVideos] = []
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient = DefaultHTTPCLient()) {
        self.httpClient = httpClient
    }
    func getMovieVideos(movieID: Int) async {
        let result = await httpClient.sendRequest(endpoint: MovieEndpoint.movieVideo(movieID: movieID),
                                       responseModel: MovieVideos.self)
        switch result {
        case .success(let data):
            resultVideos = data.results ?? []
        case .failure(let error):
            print(error.localizedDescription, error)
        }
    }
}
