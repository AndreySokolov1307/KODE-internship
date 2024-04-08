import Foundation
import UIKit
import WebKit

// swiftlint:disable:next final_class
open class BaseWebViewController<WebView: BaseWebView>: TemplateViewController<WebView>, WKUIDelegate, WKNavigationDelegate {

    public typealias UrlHandler = (URL?) -> Void

    // Properties
    private var link: String
    var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy {
        didSet {
            rootView.cachePolicy = cachePolicy
        }
    }

    // Handlers
    public var onRedirect: UrlHandler?
    public var onPageOpened: UrlHandler?
    public var onCloseTapped: (() -> Void)?

    // MARK: - Init

    public init(with link: String) {
        self.link = link
        super.init()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override open func loadView() {
        let webView = WebView(link: link)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }

    open override func setup() {
        super.setup()
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - WKUIDelegate, WKNavigationDelegate

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) { }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { }

    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) { decisionHandler(.allow) }

    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        onPageOpened?(navigationResponse.response.url)
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url {
            onRedirect?(url)
        }
    }
}
