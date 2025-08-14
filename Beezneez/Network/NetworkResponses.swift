import Foundation

enum RequestType: String {
    
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    
    var requestString: String {
        self.rawValue
    }
}

// Example of codable conforming response from another project
struct Status: Codable {
    let statusCode: Int
    let statusMessage: String?
}

struct ErrorResponse: Codable {
    let status: Status
}

// Can be used to try to decode some object T
struct GenericResponse<T: Codable>: Codable {
    let status: Status
    let data: T?
}

