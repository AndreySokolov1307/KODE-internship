import UIKit

// swiftlint:disable:next final_class
open class BaseActivityIndicatorView: UIActivityIndicatorView, StartStoppable {

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override public init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        setup()
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods to Implement

    open func setup() { }

    // MARK: - Public Methods

    open func start(completion: (() -> Void)?) {
        startAnimating()
        completion?()
    }

    open func stop(completion: (() -> Void)?) {
        stopAnimating()
        completion?()
    }
}
