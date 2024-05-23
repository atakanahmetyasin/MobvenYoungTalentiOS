import Foundation

protocol ReleaseDatesViewModelProtocol: ObservableObject {
    func getReleaseDates(movieID: Int) async
    @MainActor var resultReleaseDates: MovieReleaseDates? { get }
}

@MainActor
final class ReleaseDatesViewModel: ObservableObject {
    @Published var resultReleaseDates: MovieReleaseDates?
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient = DefaultHTTPCLient()) {
        self.httpClient = httpClient
    }
}

extension ReleaseDatesViewModel: ReleaseDatesViewModelProtocol {
    func getReleaseDates(movieID: Int) async {
        let result = await httpClient.sendRequest(endpoint: MovieEndpoint.releaseDate(movieID: movieID),
                                       responseModel: MovieReleaseDates.self)
        switch result {
        case .success(let data):
            self.resultReleaseDates = data
        case .failure(let error):
            print("asdasd", error.localizedDescription)
        }
    }
}
