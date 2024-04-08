import UIKit.UIImageView

// swiftlint:disable:next final_class
open class BaseImageView: UIImageView {

    // MARK: - Public Properties

    var onTap: (() -> Void)?

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        contentMode(.scaleAspectFit)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentMode(.scaleAspectFit)
        setup()
    }

    override public init(image: UIImage?) {
        super.init(image: image)
        contentMode(.scaleAspectFit)
        setup()
    }

    public convenience init() {
        self.init(frame: .zero)
    }

    public convenience init(size: CGSize) {
        self.init(frame: CGRect(origin: .zero, size: size))
        self.size(size)
    }

    public convenience init(configurator: (BaseImageView) -> Void) {
        self.init(frame: .zero)
        configurator(self)
    }

    // MARK: - Methods to Implement

    open func setup() { }

    open func updateAppearance() { }

    // MARK: - Public Methods

    /// This method is used ONLY together with
    /// assigning onTap handler on view, otherwise it won't be called
    /// To handle tap inside view itself, just assign onTap in it directly
    open func internalTapHandler() { }

    @discardableResult
    open func onTap(_ completion: @escaping () -> Void) -> Self {
        onTap = completion
        configureGesture()
        return self
    }
}

// MARK: - Handle tap gesture

extension BaseImageView {
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    @objc private func handleTap() {
        internalTapHandler()
        onTap?()
    }
}

