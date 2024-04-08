import UIKit.UILabel

// swiftlint:disable:next final_class
open class BaseLabel: UILabel {

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

    public convenience init(text: String?) {
        self.init(frame: .zero)
        self.text = text
        updateAppearance()
    }

    public convenience init(configurator: (BaseLabel) -> Void) {
        self.init(frame: .zero)
        configurator(self)
        updateAppearance()
    }

    public convenience init(text: String?, configurator: (BaseLabel) -> Void) {
        self.init(frame: .zero)
        self.text = text
        configurator(self)
        updateAppearance()
    }

    // MARK: - Methods to Implement

    open func setup() { }

    open func updateAppearance() { }
}
