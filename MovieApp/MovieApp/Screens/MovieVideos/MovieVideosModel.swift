import Foundation

// MARK: - MovieVideos
struct MovieVideos: Codable {
    let id: Int?
    let results: [ResultVideos]?
}

// MARK: - Result
struct ResultVideos: Codable {
    let iso6391: String?
    let iso31661: String?
    let name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum Site: String, Codable {
    case youTube = "YouTube"
}

enum TypeEnum: String, Codable {
    case clip = "Clip"
    case featurette = "Featurette"
    case trailer = "Trailer"
}
