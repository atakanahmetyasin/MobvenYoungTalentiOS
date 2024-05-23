import SwiftUI

protocol HomePageViewModelProtocol: ObservableObject {
    func getUpcomingMovies() async
    func getNowPlayingMovies() async
    func filterMovies()
    var searchText: String { get set }
    @MainActor var resultsUpcoming: [Results] { get }
    @MainActor var resultsNowPlaying: [Results] { get }
    @MainActor var filteredUpcoming: [Results] { get }
    @MainActor var filteredNowPlaying: [Results] { get }
}

@MainActor final class HomePageViewModel: ObservableObject {
    @Published var resultsUpcoming: [Results] = []
    @Published var resultsNowPlaying: [Results] = []
    @Published var filteredUpcoming: [Results] = []
    @Published var filteredNowPlaying: [Results] = []
    @Published var showingNowPlayingMovies = true
    var searchText: String = "" {
        didSet {
            filterMovies()
        }
    }
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient = DefaultHTTPCLient()) {
        self.httpClient = httpClient
    }
    func filterMovies() {
        if searchText.isEmpty {
            filteredNowPlaying = resultsNowPlaying
            filteredUpcoming = resultsUpcoming
        } else {
            filteredNowPlaying = resultsNowPlaying.filter { $0.originalTitle.localizedCaseInsensitiveContains(searchText) }
            filteredUpcoming = resultsUpcoming.filter { $0.originalTitle.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

extension HomePageViewModel: HomePageViewModelProtocol {
    func getUpcomingMovies() async {
        let result = await httpClient.sendRequest(endpoint: MovieEndpoint.comingSoon, responseModel: Movie.self)
                switch result {
                case let .success(response):
                    self.resultsUpcoming = response.results ?? []
                    self.filteredUpcoming = response.results ?? []
                case let .failure(error):
                    print(error.localizedDescription, error)
                }
    }
    func getNowPlayingMovies() async {
        let result = await httpClient.sendRequest(endpoint: MovieEndpoint.nowShowing, responseModel: Movie.self)
                switch result {
                case let .success(response):
                    self.resultsNowPlaying = response.results ?? []
                    self.filteredNowPlaying = response.results ?? []
                case let .failure(error):
                    print(error.localizedDescription, error)
                }
    }
}
