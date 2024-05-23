import Foundation

// MARK: - MovieImages
struct MovieImages: Codable {
    let backdrops: [Backdrop]?
    let id: Int?
    let logos, posters: [Backdrop]?
}

// MARK: - Backdrop
struct Backdrop: Codable, Identifiable {
    let id = UUID()
    let aspectRatio: Double?
    let height: Int?
    let iso6391: String?
    let filePath: String?
    let voteAverage: Double?
    let voteCount, width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso6391 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
