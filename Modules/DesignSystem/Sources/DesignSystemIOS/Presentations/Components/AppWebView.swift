//
//  AppWebView.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import SwiftUI
import WebKit

public struct AppWebView: UIViewRepresentable {
    private let url: URL?
    @Binding private var isLoading: Bool

    public init(url: URL?, isLoading: Binding<Bool>) {
        self.url = url
        _isLoading = isLoading
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading)
    }

    public func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = true
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url else {
            webView.loadHTMLString(
                """
                <html>
                <body style="font-family: -apple-system; padding: 24px; color: #444;">
                <h3>Unable to open article</h3>
                <p>The article URL is missing or invalid.</p>
                </body>
                </html>
                """,
                baseURL: nil
            )
            DispatchQueue.main.async {
                isLoading = false
            }
            return
        }

        if webView.url != url {
            DispatchQueue.main.async {
                isLoading = true
            }
            webView.load(URLRequest(url: url))
        }
    }

    public final class Coordinator: NSObject, WKNavigationDelegate {
        @Binding private var isLoading: Bool

        init(isLoading: Binding<Bool>) {
            _isLoading = isLoading
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            _ = error
            isLoading = false
        }

        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            _ = error
            isLoading = false
        }
    }
}
