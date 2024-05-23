@testable import MovieApp
import SwiftData

class MockMovieDataSource: MovieDataSourceProtocol {
    private var context: ModelContext!
    @MainActor
    var mockContainer: ModelContainer {
        do {
            let container = try ModelContainer(for: FavoritedMovie.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }
    var movies = [FavoritedMovie]()
    var appendMoviesCalled = false
    var fetchMoviesCalled = false
    var removeMovieCalled = false

    func appendMovies(movie: FavoritedMovie) {
        appendMoviesCalled = true
        context.insert(movie)
//        movies.append(movie)
    }

    func fetchMovies() -> [FavoritedMovie] {
        fetchMoviesCalled = true
        return movies
    }

    func removeMovie(_ movie: FavoritedMovie) {
        removeMovieCalled = true
        context.delete(movie)
//        if let index = movies.firstIndex(where: { $0.movieID == movie.movieID }) {
//            movies.remove(at: index)
        }
    }

