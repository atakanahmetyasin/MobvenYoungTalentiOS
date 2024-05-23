//
//  DataViewModelTests.swift
//  MovieAppTests
//
//  Created by Ahmet Yasin Atakan on 13.05.2024.
//


import XCTest
import SwiftData
@testable import MovieApp





//@MainActor
//var mockContainer: ModelContainer {
//    do {
//        let container = try ModelContainer(for: FavoritedMovie.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
//        return container
//    } catch {
//        fatalError("Failed to create container")
//    }
//}
//
//
//final class UTDemoTests: XCTestCase {
//    private var context: ModelContext!
//    
//    @MainActor
//    override func setUp() async throws {
//        context = mockContainer.mainContext
//    }
//    
//    func testIfMovieInserted() throws {
//        let movie = FavoritedMovie(movieID: 1, imageURL: "https:", movieName: "Batman", rating: 9.2, genre: "Crime", duration: "130m")
//        context.insert(movie)
//        
//        XCTAssertThrowsError(try movie.)
//    }
//}
// 






class DataViewModelTests: XCTestCase {
    var viewModel: SwiftDataViewModel!
    var mockDataSource: MockMovieDataSource!
    
    override func setUp() {
        super.setUp()
        mockDataSource = MockMovieDataSource()
        viewModel = SwiftDataViewModel(dataSource: mockDataSource)
        
        let movie1 = FavoritedMovie(movieID: 1, imageURL: "url1", movieName: "Movie 1", rating: 5.0, genre: "Action", duration: "120 mins")
        let movie2 = FavoritedMovie(movieID: 2, imageURL: "url2", movieName: "Movie 2", rating: 6.0, genre: "Comedy", duration: "90 mins")
        mockDataSource.appendMovies(movie: movie1)
        mockDataSource.appendMovies(movie: movie2)
        viewModel.fetchMovies()
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataSource = nil
        super.tearDown()
    }
    
    func testAppendMovie() {
        // Given
        let initialCount = mockDataSource.movies.count
        let movieID = 3
        let imageURL = "https://example.com/image.png"
        let movieName = "Test Movie"
        let rating = 8.2
        let genre = "Test Genre"
        let duration = "120 mins"
        
        // When
        viewModel.appendMovie(movieID: movieID, imageURL: imageURL, movieName: movieName, rating: rating, genre: genre, duration: duration)
        
        // Then
        XCTAssertTrue(mockDataSource.appendMoviesCalled, "appendMovies was not called ")
        XCTAssertEqual(mockDataSource.movies.count, initialCount + 1, "No movies were appended")
        XCTAssertEqual(mockDataSource.movies.last?.movieName, movieName, "The movie appended does not match the expected movie")
    }
    func testRemoveMovie() {
        // Given
        let initialCount = viewModel.movies.count
        let movieToRemove = viewModel.movies.first!
        
        // When
        viewModel.removeItem(at: 0)
        
        // Then
        XCTAssertTrue(mockDataSource.removeMovieCalled, "removeMovie was not called on the data source")
        XCTAssertEqual(viewModel.movies.count, initialCount - 1, "Movie count did not decrease")
        XCTAssertFalse(viewModel.movies.contains(movieToRemove), "Movie was not removed from the list")
    }
}
