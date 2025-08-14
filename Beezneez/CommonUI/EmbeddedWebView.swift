import WebKit
import SwiftUI
import OSLog

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
}
