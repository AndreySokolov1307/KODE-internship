import UIKit.UIControl

// swiftlint:disable:next final_class
open class BaseControl: UIControl {

    // MARK: - Properties

    override open var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    override open var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    override open var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }

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

    // MARK: - Methods to Implement

    open func setup() { }

    open func updateAppearance() { }
}
