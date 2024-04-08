import UIKit.UIView

// swiftlint:disable:next final_class
open class BaseView: UIView {

    // MARK: - Public Properties

    public private(set) var onTap: (() -> Void)?

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateAppearance()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        updateAppearance()
    }

    public convenience init(configurator: (BaseView) -> Void) {
        self.init()
        configurator(self)
    }

    // MARK: - Public Methods

    open func setup() { }

    open func updateAppearance() { }

    /// This method is used ONLY together with
    /// assigning onTap handler on view, otherwise it won't be called
    /// To handle tap inside view itself, just assign onTap in it directly
    open func internalTapHandler() { }

    /// This method is used to modify gesture recognizer if needed
    open func makeTapGestureRecognizer() -> UITapGestureRecognizer {
        UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }

    @discardableResult
    open func onTap(_ completion: @escaping () -> Void) -> Self {
        onTap = completion
        configureGesture()
        return self
    }
}

// MARK: - Handle tap gesture

extension BaseView {
    private func configureGesture() {
        let tap = makeTapGestureRecognizer()
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    @objc private func handleTap() {
        internalTapHandler()
        onTap?()
    }
}
