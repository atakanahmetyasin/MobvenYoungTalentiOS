import XCTest
@testable import MovieApp



class HomePageViewModelTests: XCTestCase {
    var viewModel: HomePageViewModel!
    var mockHTTPClient: MockHTTPClient!
    
    @MainActor override func setUp() {
        super.setUp()
        mockHTTPClient = MockHTTPClient()
        viewModel = HomePageViewModel(httpClient: mockHTTPClient)
    }
    
    @MainActor
    func testGetNowPlayingMovies_Success() async {
        let mockMovie = Movie(page: 1, results: [Results(adult: false, backdropPath: nil, genreIDS: nil, id: 1, originalLanguage: "en", originalTitle: "Test", overview: "Overview", popularity: nil, posterPath: nil, releaseDate: nil, title: "Test", video: false, voteAverage: nil, voteCount: nil)], totalPages: 1, totalResults: 1)
        mockHTTPClient.result = .success(mockMovie)
        
        await viewModel.getNowPlayingMovies()
        
        XCTAssertEqual(viewModel.resultsNowPlaying.count, 1)
        XCTAssertEqual(viewModel.filteredNowPlaying.count, 1)
    }
    
    @MainActor func testGetNowPlayingMovies_Failure() async {
        mockHTTPClient.result = .failure(.unknown)
        
        await viewModel.getNowPlayingMovies()
        
        XCTAssertEqual(viewModel.resultsNowPlaying.count, 0)
        XCTAssertEqual(viewModel.filteredNowPlaying.count, 0)
    }
    
    @MainActor func testFilterMovies() {
        viewModel.resultsNowPlaying = [Results(adult: false, backdropPath: nil, genreIDS: nil, id: 1, originalLanguage: "en", originalTitle: "Test Movie", overview: "Overview", popularity: nil, posterPath: nil, releaseDate: nil, title: "Test Movie", video: false, voteAverage: nil, voteCount: nil)]
        
        viewModel.searchText = "Test"
        
        XCTAssertEqual(viewModel.filteredNowPlaying.count, 1)
        
        viewModel.searchText = "No Movie"
        
        XCTAssertEqual(viewModel.filteredNowPlaying.count, 0)
    }
}
