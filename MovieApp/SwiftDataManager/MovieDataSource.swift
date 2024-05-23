//
//  ItemDataSource.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 11.05.2024.
//

import SwiftData
import SwiftUI

protocol MovieDataSourceProtocol {
    func appendMovies(movie: FavoritedMovie)
    func fetchMovies() -> [FavoritedMovie]
    func removeMovie(_ movie: FavoritedMovie)
}

final class MovieDataSource: MovieDataSourceProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = MovieDataSource()

    @MainActor
    private init() {
        do {
            self.modelContainer = try ModelContainer(for: FavoritedMovie.self)
        } catch {
            fatalError("Error Model Container: \(error.localizedDescription), error: \(error)")
        }
        self.modelContext = modelContainer.mainContext
    }

    func appendMovies(movie: FavoritedMovie) {
        modelContext.insert(movie)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchMovies() -> [FavoritedMovie] {
        do {
            return try modelContext.fetch(FetchDescriptor<FavoritedMovie>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeMovie(_ movie: FavoritedMovie) {
        modelContext.delete(movie)
        print("Deleted")
    }
}
