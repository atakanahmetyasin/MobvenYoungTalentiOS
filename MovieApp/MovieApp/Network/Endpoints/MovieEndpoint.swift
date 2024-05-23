import Foundation

enum MovieEndpoint {
    case nowShowing
    case comingSoon
    case detail(movieID: Int)
    case movieImage(movieID: Int)
    case movieVideo(movieID: Int)
    case credits(movieID: Int)
    case releaseDate(movieID: Int)
}
//
extension MovieEndpoint: Endpoint {
    var method: RequestMethod {
        switch self {
        case  .nowShowing, .comingSoon, .detail, .movieImage, .movieVideo, .credits, .releaseDate:
            return .get
        }
    }
    var header: [String: String]? {
        switch self {
        case .nowShowing, .comingSoon, .detail, .movieImage, .movieVideo, .credits, .releaseDate:
            return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9" +
                ".eyJhdWQiOiI3N2ZmNzExZjAxYjE0YjFjO" +
                "DE0Zjc2YTRhNGM1NzEwZSIsInN1YiI6IjY2MzEwMTBjOTBkZGUwMDEyYzJhNDdiYiIsInNjb3BlcyI6WyJhcGlfcm" +
                "VhZCJdLCJ2ZXJzaW9uIjoxfQ.8IYGPisp7ChsDSqN-lywDmH8guX0rQaQ_cFy_Gd_byQ"
            ]
        }
    }
    var body: [String: String]? {
        return nil
    }
    var path: String {
        switch self {
        case .nowShowing:
            return "/3/movie/now_playing"
        case .comingSoon:
            return "/3/movie/upcoming"
        case .detail(let movieID):
            return "/3/movie/\(movieID)"
        case .movieImage(let movieID):
            return "/3/movie/\(movieID)/images"
        case .movieVideo(let movieID):
            return "/3/movie/\(movieID)/videos"
        case .credits(let movieID):
            return "/3/movie/\(movieID)/credits"
        case .releaseDate(let movieID):
            return "/3/movie/\(movieID)/release_dates"
        }
    }
}
