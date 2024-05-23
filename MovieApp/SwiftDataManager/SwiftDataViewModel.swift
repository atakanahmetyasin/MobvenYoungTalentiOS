//
//  SwiftDataViewModel.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 11.05.2024.
//

import SwiftUI
import SwiftData

protocol SwiftDataViewModelProtocol: ObservableObject {
    var movies: [FavoritedMovie] { get }
    func appendMovie(movieID: Int, imageURL: String, movieName: String, rating: Double, genre: String, duration: String)
    func removeItem(at index: Int)
    func fetchMovies()
}

final class SwiftDataViewModel: ObservableObject, SwiftDataViewModelProtocol {
    @Published var movies: [FavoritedMovie] = []
    private var dataSource: MovieDataSourceProtocol
    init(dataSource: MovieDataSourceProtocol = MovieDataSource.shared) {
        self.dataSource = dataSource
        fetchMovies()
    }
    func appendMovie(movieID: Int, imageURL: String, movieName: String, rating: Double, genre: String, duration: String) {
        let newMovie = FavoritedMovie(movieID: movieID, imageURL: imageURL, movieName: movieName, rating: rating, genre: genre, duration: duration)
        dataSource.appendMovies(movie: newMovie)
        fetchMovies()
        print(movies.count)
    }
    func removeItem(at index: Int) {
        let movie = movies[index]
        dataSource.removeMovie(movie)
        fetchMovies()
        print(movies.count)
    }
    func fetchMovies() {
        movies = dataSource.fetchMovies()
    }
}
