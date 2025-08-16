import Foundation
import OSLog

enum RequestType: String {
    
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    
    var requestString: String {
        self.rawValue
    }
}

struct GenericResponse<T: Codable>: Codable {
    let data: T?
}

struct NetworkService {
        
    func createJsonBody(_ body: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: body)
        } catch {
            Logger.createLog(type: .error, message: "Could not convert request body to JSON data: \(error)")
            return nil
        }
    }
    
    // TODO: - Below is legacy completion based, update to return response

    func createRequest(type: RequestType, url: URL, body: Data?, authRequired: Bool, successCompletion: @escaping (Data) -> Void, failureCompletion: ((String) -> Void)?) {
        
        var request = URLRequest(url: url)

        if let body {
            request.httpBody = body
        }
        
        request.httpMethod = type.requestString
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if authRequired {
            guard let token = TokenService().getJWTFromKeychain(key: "sfbundletoken") else {
                if let failureCompletion {
                    failureCompletion("Could not complete request, re-login in and try again")
                }
                return
            }
            
            let bearerToken = "Bearer \(token)"
            request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        }

        beginTask(request: request, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
    
    private func beginTask(request: URLRequest, successCompletion: @escaping (Data) -> Void, failureCompletion: ((String) -> Void)?) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            Logger.createLog(type: .debug, message: "Request URL: \(request.debugDescription)")
            Logger.createLog(type: .debug, message: "Request Body: \(String(describing: String(data: request.httpBody ?? Data(), encoding: .utf8)))")
            
            if let error = error {
                Logger.createLog(type: .error, message: "A network request error occured: \(error)")
                if let failureCompletion {
                    failureCompletion("Network error - Operation could not be completed. Please try again")
            }
                return
            }
            
            guard let data = data else {
                Logger.createLog(type: .error, message: "No data has been received in the response")
                if let failureCompletion {
                    failureCompletion("Network error - Operation could not be completed. Please try again")
                }
                return
            }
            
            Logger.createLog(type: .info, message: "Received response from server")
            
            if let urlResponse = response as? HTTPURLResponse {
                
                Logger.createLog(type: .debug, message: "First Response Code: \(urlResponse.statusCode) for URL: \(String(describing: urlResponse.url?.absoluteString))")

                if urlResponse.statusCode == 200 {
                    successCompletion(data)
                    
                } else if urlResponse.statusCode == 404 { /// API cannot process the request, and cannot respond with a body for us to parse to a failure. Special case error. Could be database related if working in dev environment, or the endpoint is missing
                    if let failureCompletion {
                        failureCompletion("Error 404 - Not Found")
                    }
                } else {
//                    self?.decodeFailureResponse(data, successCompletion: successCompletion, failureCompletion: failureCompletion)
                }
            } else {
                Logger.createLog(type: .error, message: "Response is not the correct type")
                if let failureCompletion {
                    failureCompletion("Invalid Response")
                }
            }
        }
        
        task.resume()
    }
            
    // MARK: - Decoding helpers
    
    func decodeObjectFromData<T: Decodable>(_ data: Data, objectType: T.Type) -> T? {
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(objectType, from: data)
        } catch {
            Logger.createLog(type: .error, message: "Could not decode data to object: \(error.localizedDescription)")
            return nil
        }
    }
    
    func decodeValueFromDataAndKey(_ data: Data, key: String) -> String? {
        
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                Logger.createLog(type: .debug, message: jsonObject.debugDescription)
                if let value = jsonObject[key] as? String {
                    Logger.createLog(type: .debug, message: "Found \(key) key")
                    return value
                } else {
                    Logger.createLog(type: .debug, message: "Could not find key: \(key)")
                }
            }
        } catch {
            Logger.createLog(type: .error, message: "Could not parse from jsonObject: \(error)")
        }
        
        return nil
    }
}
