import Foundation
import UIKit
import WebKit
import Combine
import SnapKit

// swiftlint:disable:next final_class
open class BaseWebView: WKWebView, WKUIDelegate {

    // MARK: - Public Properties

    public var cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
    public var loadingPublisher: AnyPublisher<Bool, Never> { loadingSubject.eraseToAnyPublisher() }

    // MARK: - Private Properties

    fileprivate var link = String()
    fileprivate let webConfiguration = WKWebViewConfiguration()
    fileprivate let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    fileprivate var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    public required init(link: String) {
        super.init(frame: .zero, configuration: webConfiguration)
        self.link = link
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Methods

    open func set(link: String) {
        self.link = link
        setupInitialPage()
    }

    open func setup() {
        setupInitialPage()
    }

    open func setupInitialPage() {
        guard let URL = URL(string: link) else {
            return
        }
        let request = URLRequest(url: URL, cachePolicy: .useProtocolCachePolicy)
        load(request)
    }
}

/// Shows overlay and loader above main content
open class BaseStatefullWebView<Loader: UIView, Overlay: UIView>: BaseWebView {
// swiftlint:disable:previous final_class

    // MARK: - Subviews

    public let overlayView = Overlay()
    public let loaderView = Loader()

    // MARK: - Public Methods

    override open func setup() {
        super.setup()
        layout()
        setupBindings()
    }

    // MARK: - Private Methods

    open func layout() {
        embed(subview: overlayView)
        embedAtCenter(subview: loaderView)

        overlayView.alpha = 0
    }

    open func setupBindings() {
        loadingSubject.removeDuplicates().sink { [weak self] isLoading in
            if isLoading {
                self?.overlayView.fadeIn()
                (self?.loaderView as? StartStoppable)?.start()
            } else {
                self?.overlayView.fadeOut()
                (self?.loaderView as? StartStoppable)?.stop()
            }
        }.store(in: &cancellables)
    }
}
