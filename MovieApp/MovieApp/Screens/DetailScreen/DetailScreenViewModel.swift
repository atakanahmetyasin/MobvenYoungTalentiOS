import SwiftUI

protocol DetailScreenViewModelProtocol: ObservableObject {
    func getMoviesDetail(movieID: Int) async
    @MainActor var detailResult: MovieDetails? { get }
}

@MainActor final class DetailScreenViewModel: ObservableObject {
    @Published var detailResult: MovieDetails?
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient = DefaultHTTPCLient()) {
        self.httpClient = httpClient
    }
}
extension DetailScreenViewModel: DetailScreenViewModelProtocol {
        func getMoviesDetail(movieID: Int) async {
            let result = await httpClient.sendRequest(endpoint: MovieEndpoint.detail(movieID: movieID),
                                       responseModel: MovieDetails.self)
        switch result {
        case .success(let data):
            detailResult = data
        case .failure(let error):
            print(error.localizedDescription, error)
        }
    }
}
