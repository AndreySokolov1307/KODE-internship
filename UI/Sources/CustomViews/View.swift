import UIKit

// swiftlint:disable:next final_class
open class View: BaseView, KeyboardChangeListener, Themeable {

    // MARK: - Public Properties

    open var actionButton: BaseBrandButton? {
        didSet {
            oldValue?.removeFromSuperview()
            setupActionButton()
        }
    }
    open var moveActionButtonWithKeyboard: Bool = false

    // MARK: - Private Properties

    private weak var actionButtonBottomConstraint: NSLayoutConstraint?

    public private(set) var backgroundStyle: BackgroundStyle?
    public private(set) var shadowStyle: ShadowStyle?
    public private(set) var borderStyle: BorderStyle?

    // MARK: - Init

    public init() {
        super.init(frame: .zero)
    }

    public init(backgroundStyle: BackgroundStyle? = nil, shadowStyle: ShadowStyle? = nil) {
        self.backgroundStyle = backgroundStyle
        self.shadowStyle = shadowStyle
        super.init(frame: .zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override open func setup() {
        super.setup()
        listenKeyboardChanges()
        subscribeOnThemeChanges()
    }

    open func keyboardChanged(_ props: KeyboardChangeProps) {
        guard moveActionButtonWithKeyboard else { return }
        actionButtonBottomConstraint?.constant = -props.targetHeight - 12
        props.animateLayoutIfNeeded(view: self)
    }

    @discardableResult
    public func backgroundStyle(_ backgroundStyle: BackgroundStyle) -> Self {
        self.backgroundStyle = backgroundStyle
        backgroundColor(backgroundStyle.color)
        return self
    }

    @discardableResult
    public func shadowStyle(_ shadowStyle: ShadowStyle) -> Self {
        self.shadowStyle = shadowStyle
        shadow(shadowStyle.shadowProps)
        return self
    }

    @discardableResult
    public func borderStyle(_ borderStyle: BorderStyle, width: CGFloat = 1) -> Self {
        self.borderStyle = borderStyle
        self.borderWidth = width

        updateAppearance()
        return self
    }

    @discardableResult
    public func removeBorder() -> Self {
        borderStyle = nil
        borderColor(.clear)
        borderWidth(.zero)
        return self
    }

    override open func updateAppearance() {
        super.updateAppearance()
        if let backgroundStyle {
            backgroundColor(backgroundStyle.color)
        }
        if let borderStyle {
            borderColor(borderStyle.color)
        }
        if let shadowStyle {
            shadow(shadowStyle.shadowProps)
        }
    }

    func endEditingOnTap() {
        onTap { [unowned self] in self.endEditing(true) }
    }

    func additionalScrollInsetForActionButton() -> CGFloat {
        (self.actionButton?.frame.height ?? 0) + (12 * 2)
    }

    // MARK: - Private Methods

    private func setupActionButton() {
        guard let actionButton = actionButton else { return }
        addSubview(actionButton)
        actionButton.pinHorizontalEdges(to: self, inset: 16)
        actionButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        let actionButtonBottomConstraint = actionButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        actionButtonBottomConstraint.priority = .defaultLow
        self.actionButtonBottomConstraint = actionButtonBottomConstraint
        actionButtonBottomConstraint.isActive = true
    }
}
