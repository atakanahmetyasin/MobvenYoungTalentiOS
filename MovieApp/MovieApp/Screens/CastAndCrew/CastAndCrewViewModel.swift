import Foundation

protocol CastAndCrewViewModelProtocol: ObservableObject {
    func getCastAndCrew(movieID: Int) async
    @MainActor var resultMovieCast: [Cast] { get }
}

@MainActor final class CastAndCrewViewModel: ObservableObject, CastAndCrewViewModelProtocol {
    @Published var resultMovieCast: [Cast] = []
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient = DefaultHTTPCLient()) {
        self.httpClient = httpClient
    }
    func getCastAndCrew(movieID: Int) async {
        let result = await httpClient.sendRequest(endpoint: MovieEndpoint.credits(movieID: movieID), responseModel: MovieCast.self)
        switch result {
        case .success(let data):
            resultMovieCast = data.cast ?? []
        case .failure(let error):
            print(error.localizedDescription, error)
        }
    }
}
