import UIKit

// swiftlint:disable:next final_class
open class BaseSpacer: BaseView, ConfigurableView, ProvidesHeight {

    public struct Props {

        /// `BaseSpacer` will detect the superview axis (for `UIStackView`)
        /// and automatically assign `length` to `height` or `width` according to the main axis.
        /// If superview hasn't axis, length will be assigned to `height`.
        /// Length in other dimension will be `.infinite`
        public let length: CGFloat?
        public let backgroundColor: UIColor?

        public init(length: CGFloat?, backgroundColor: UIColor?) {
            self.length = length
            self.backgroundColor = backgroundColor
        }
    }

    // MARK: - Properties

    public var height: CGFloat { frame.height }
    private let props: Props?
    private var isInsideHorizontalView = false

    // MARK: - Init

    public init(props: Props) {
        self.props = props
        super.init(frame: .zero)
    }

    public convenience init(length: CGFloat) {
        self.init(props: Props(length: length, backgroundColor: nil))
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override public func willMove(toSuperview newSuperview: UIView?) {
        if let newSuperview {
            detectSuperviewAxis(superview: newSuperview)
        }
        super.willMove(toSuperview: newSuperview)
    }

    override open func didMoveToSuperview() {
        if superview != nil {
            layout()
        }
        super.didMoveToSuperview()
    }

    // MARK: - Public Methods

    override open func setup() {
        super.setup()
    }

    public func configure(with model: Props) {
        updateAppearance()
    }

    override public func updateAppearance() {
        super.updateAppearance()
        backgroundColor = props?.backgroundColor
    }

    /// Try to detect the superview axis (for `UIStackView`) and automatically assign `length` to `height` or `width`.
    /// If superview hasn't axis, length will be assigned to `height`.
    /// Length in other dimension will be `.infinite`
    open func layout() {
        guard let length = props?.length else {
            return
        }

        if isInsideHorizontalView {
            width(length)
            setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        } else {
            height(length)
            setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        }

        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    open func detectSuperviewAxis(superview: UIView) {
        isInsideHorizontalView = (superview as? UIStackView).flatMap { $0.axis == .horizontal } ?? false
    }
}
