import UIKit.UITextView

// swiftlint:disable:next final_class
open class BaseTextField: UITextField {

    // MARK: - Properties

    public var onDeleteBackward: (() -> Void)?

    private var placeholderText: String {
        return (attributedPlaceholder?.string ?? placeholder) ?? ""
    }

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public convenience init(text: String?) {
        self.init(frame: .zero)
        self.text = text
    }

    public convenience init(placeholder: String?) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }

    public convenience init(configurator: (BaseTextField) -> Void) {
        self.init(frame: .zero)
        configurator(self)
    }

    public convenience init(text: String?, configurator: (BaseTextField) -> Void) {
        self.init(frame: .zero)
        self.text = text
        configurator(self)
    }

    public convenience init(placeholder: String?, configurator: (BaseTextField) -> Void) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        configurator(self)
    }

    // MARK: - Public Methods

    override open func deleteBackward() {
        super.deleteBackward()
        onDeleteBackward?()
    }

    open func setup() {
        backgroundColor = .clear
    }

    @discardableResult
    func clear() -> Self {
        text = ""
        return self
    }

    open func updateAppearance() { }
}
