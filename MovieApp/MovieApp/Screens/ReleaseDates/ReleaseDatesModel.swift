import Foundation

// MARK: - MovieVideos
struct MovieReleaseDates: Codable {
    let id: Int?
    let results: [ResultReleaseDates]
}

// MARK: - Result
struct ResultReleaseDates: Codable, Identifiable {
    var id = UUID()
    let iso31661: String?
    let releaseDates: [ReleaseDate]?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case releaseDates = "release_dates"
    }
}

// MARK: - ReleaseDate
struct ReleaseDate: Codable, Identifiable {
    var id = UUID()
    let certification: String?
    let descriptors: [String]?
    let iso6391: String?
    let note, releaseDate: String?
    let type: Int?

    enum CodingKeys: String, CodingKey {
        case certification, descriptors
        case iso6391 = "iso_639_1"
        case note
        case releaseDate = "release_date"
        case type
    }
}
