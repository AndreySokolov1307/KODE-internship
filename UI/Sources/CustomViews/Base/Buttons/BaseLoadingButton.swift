import UIKit

// swiftlint:disable:next final_class
open class BaseLoadingButton: BaseAccessoryButton {

    // MARK: - Properties

    public var loaderView: UIView?

    private var wasEnabledBeforeLoading: Bool?

    public private(set) var isLoading = false {
        didSet {
            updateAppearance()
        }
    }

    // MARK: - Public Methods

    override open func updateAppearance() {
        super.updateAppearance()

        setupDefaultAppearance()

        if isEnabled {
            if isHighlighted || isSelected {
                setupActiveAppearance()
            } else {
                setupNormalAppearance()
            }
        } else {
            if isLoading {
                setupLoadingAppearance()
            } else {
                setupDisabledAppearance()
            }
        }
    }

    open func layoutLoaderIfNeeded() {
        loaderView?.embedAtCenter(of: accessoryView ?? self)
    }

    open func startLoading() {
        wasEnabledBeforeLoading = isEnabled
        isEnabled = false

        isLoading = true
        if loaderView == nil {
            loaderView = makeLoaderView()
        }
        layoutLoaderIfNeeded()

        DispatchQueue.main.async { [weak loaderView] in
            (loaderView as? StartStoppable)?.start()
        }
    }

    open func stopLoading() {
        if let wasEnabledBeforeLoading {
            isEnabled = wasEnabledBeforeLoading
            self.wasEnabledBeforeLoading = nil
        }

        isLoading = false

        DispatchQueue.main.async { [weak loaderView] in
            (loaderView as? StartStoppable)?.stop()
        }
    }

    // MARK: - Methods to implement

    open func makeLoaderView() -> UIView {
        return BaseView()
    }

    open func setupDefaultAppearance() { }
    open func setupNormalAppearance() { }
    open func setupActiveAppearance() { }
    open func setupLoadingAppearance() { }
    open func setupDisabledAppearance() { }
}
