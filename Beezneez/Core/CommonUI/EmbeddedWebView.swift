import WebKit
import SwiftUI
import OSLog
import SafariServices

struct EmbeddedWebView: UIViewRepresentable {
    
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        Logger.createLog(type: .info, message: "Created Embedded Web View")
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        Logger.createLog(type: .info, message: "Made request to open URL: \(url.absoluteString)")
        uiView.load(request)
    }
    
    func openSafariWebview(url: URL) {
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .automatic
        
        Logger.createLog(type: .info, message: "About to open webview with URL: \(url.absoluteString)")
        
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController?.present(safariViewController, animated: true, completion: {
            Logger.createLog(type: .info, message: "URL has opened in webview")
        })
    }
}
