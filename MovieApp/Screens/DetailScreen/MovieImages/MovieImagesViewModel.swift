import SwiftUI

protocol MovieImagesViewModelProtocol: ObservableObject {
    func fetchMovieImages(movieID: Int) async
    @MainActor var imagesResult: [Backdrop] { get }
}

@MainActor final class MovieImagesViewModel: ObservableObject {
    @Published var imagesResult: [Backdrop] = []
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient = DefaultHTTPCLient()) {
        self.httpClient = httpClient
    }
}

extension MovieImagesViewModel: MovieImagesViewModelProtocol {
    func fetchMovieImages(movieID: Int) async {
        let result = await httpClient.sendRequest(endpoint: MovieEndpoint.movieImage(movieID: movieID),
                                       responseModel: MovieImages.self)
        switch result {
        case .success(let data):
            imagesResult = data.backdrops ?? []
        case .failure(let error):
            print(error.localizedDescription, error)
        }
    }
}
