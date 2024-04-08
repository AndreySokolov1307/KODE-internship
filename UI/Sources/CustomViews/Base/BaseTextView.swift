import UIKit.UITextView

// swiftlint:disable:next final_class
open class BaseTextView: UITextView {

    // MARK: - Init

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
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

    public convenience init(configurator: (BaseTextView) -> Void) {
        self.init(frame: .zero)
        configurator(self)
    }

    public convenience init(text: String?, configurator: (BaseTextView) -> Void) {
        self.init(frame: .zero)
        self.text = text
        configurator(self)
    }

    // MARK: - Public Methods

    open func setup() {
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        isEditable = false
        textContainer.maximumNumberOfLines = 0
        textContainer.lineBreakMode = .byWordWrapping
        dataDetectorTypes = [.phoneNumber, .link]
        isSelectable = true
        isScrollEnabled = false
        backgroundColor = .clear
    }

    open func updateAppearance() { }
}
