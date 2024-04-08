import UIKit.UIButton

// swiftlint:disable:next final_class
open class BaseButton: UIButton {

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

    public init(title: String? = nil, image: UIImage? = nil) {
        super.init(frame: .zero)
        if let title {
            setTitle(title, for: .normal)
        }
        if let image {
            setImage(image, for: .normal)
        }
        setup()
        updateAppearance()
    }

    public convenience init(buttonType: ButtonType = .custom) {
        self.init(type: buttonType)
    }

    // MARK: - Methods to Implement

    open func setup() { }

    open func updateAppearance() { }
}
