import Foundation
@testable import MovieApp

class MockHTTPClient: HTTPClient {
    var result: Result<Movie, RequestError>?
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        return result as! Result<T, RequestError>
    }
}
