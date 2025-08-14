import Foundation
import OSLog
import UIKit

enum RedirectPaths: String {
    /// Add any app routes to direct to various areas in the app
    case myAppRoute = "some/route/to/this"
}

extension Notification.Name {
    /// App-wide, code only based notifications. The user does not see these
    /// Similar to an environment variable we listen to but very easily triggered
    /// Another use case in SwifTUI, to perform an action after popping back to the home page in iOS15
    static let someNotification = Notification.Name("SomeNotification")
}

class URLCallbackWorker {
    
    func callBackFromURL(url: URL) {
        Logger.createLog(type: .info, message: "Callback made to app with URL: \(url.absoluteString)")
        let redirectPath = extractRedirectPathFromURL(url: url)
        if redirectPath == RedirectPaths.myAppRoute.rawValue {
            Logger.createLog(type: .info, message: "Callback is from HomeConnect with redirect path: \(String(describing: redirectPath))")
            redirectFromURLCallback(url: url)
            return
        }
        Logger.createLog(type: .error, message: "Unknown redirect path: \(String(describing: redirectPath))")
    }
    
    private func extractRedirectPathFromURL(url: URL) -> String? {
        
        /// Grabs the specific my-app-route path or similar, from the start of the URL
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            Logger.createLog(type: .error, message: "Could not grab components from URL: \(url.absoluteString)")
            return nil
        }
        return components.host?.components(separatedBy: "/").last
    }
    
    // MARK: - Redirect from URL Callback
    
    func redirectFromURLCallback(url: URL) {
        Logger.createLog(type: .info, message: "Dismissing webview")
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController?.presentedViewController?.dismiss(animated: true) {
                NotificationCenter.default.post(name: .someNotification, object: nil)
        }
        
        /// Example for grabbing some data back from the URL that we want to use
        let codeAndGrantType = extractCodeAndGrantTypeFromURL(url: url)
        
        // Then perform an action based upon that
            // ......
    }
    
    func extractCodeAndGrantTypeFromURL(url: URL) -> (code: String?, grantType: String?) {
        
        /// Example extraction of some query parameters returned in a URL
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            Logger.createLog(type: .error, message: "Could not grab components from URL: \(url.absoluteString)")
            return (nil, nil)
        }
            
        guard  let queryItems = components.queryItems else {
            Logger.createLog(type: .error, message: "Could not grab query items from components: \(components.description)")
            return (nil, nil)
        }
        
        var code: String?
        var grantType: String?
        
        queryItems.forEach {
            if $0.name == "code" {
                code = $0.value
            } else if $0.name == "grant_type" {
                grantType = $0.value
            }
        }
        
        Logger.createLog(type: .info, message: "Query Code: \(String(describing: code))/nQuery Grant Type: \(String(describing: grantType))")
        return (code, grantType)
    }
}
