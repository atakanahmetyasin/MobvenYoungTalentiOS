import Foundation
import SwiftData

@Model
final class FavoritedMovie {
    @Attribute(.unique)  var id = UUID()
    var movieID: Int
    var imageURL: String
    var movieName: String
    var rating: Double
    var genre: String
    var duration: String
    init(movieID: Int, imageURL: String, movieName: String, rating: Double, genre: String, duration: String) {
        self.movieID = movieID
        self.imageURL = imageURL
        self.movieName = movieName
        self.rating = rating
        self.genre = genre
        self.duration = duration
    }
}
