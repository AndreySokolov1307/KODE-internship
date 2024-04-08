import UIKit

// swiftlint:disable:next final_class
open class BaseSeparator: BaseView, ConfigurableView {

    public struct Props {

        public let height: CGFloat
        public let backgroundColor: UIColor
        public let separatorColor: UIColor
        public let insets: UIEdgeInsets

        public init(
            height: CGFloat,
            backgroundColor: UIColor,
            separatorColor: UIColor,
            insets: UIEdgeInsets
        ) {
            self.height = height
            self.backgroundColor = backgroundColor
            self.separatorColor = separatorColor
            self.insets = insets
        }
    }

    // MARK: - Properties

    public let separatorView = UIView()
    public private(set) var props: Props?

    override open var intrinsicContentSize: CGSize {
        return CGSize(
            width: UIScreen.main.bounds.width,
            height: props?.height ?? 0
        )
    }

    // MARK: - Init

    public init(props: Props) {
        self.props = props
        super.init(frame: .zero)
        configure(with: props)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override open func setup() {
        super.setup()
        addSubview(separatorView)
    }

    open func configure(with model: Props) {
        props = model
        separatorView.pinToSuperviewEdges(insets: model.insets)
        updateConstraints()
        updateAppearance()
    }

    override open func updateAppearance() {
        super.updateAppearance()
        guard let props else {
            return
        }
        backgroundColor = props.backgroundColor
        separatorView.backgroundColor = props.separatorColor
    }
}
