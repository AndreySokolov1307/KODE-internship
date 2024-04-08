import UIKit

// swiftlint:disable:next final_class
open class BaseStackView: UIStackView {

    // MARK: - Public Properties

    var onTap: (() -> Void)?

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public init(
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        super.init(frame: .zero)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        setup()
    }

    public convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(
            axis: axis,
            alignment: alignment,
            distribution: distribution,
            spacing: spacing
        )
        arrangedSubviews.forEach {
            $0.willMove(toSuperview: self)
            addArrangedSubview($0.noMaskTranslation())
            $0.didMoveToSuperview()
        }
        linkGroupedSpacers()
    }

    public convenience init(
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        @StackViewBuilder content: () -> [UIView]
    ) {
        self.init(
            arrangedSubviews: content(),
            axis: axis,
            alignment: alignment,
            distribution: distribution,
            spacing: spacing
        )
    }

    // MARK: - Public Methods

    open func setup() { }

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

    /// Find all grouped spacers and make them equal by height/width (according to the axis)
    @discardableResult
    public func linkGroupedSpacers() -> Self {
        let linkedSpacers: [FlexibleGroupedSpacer] = arrangedSubviews.compactMap { subview in
            if let linkedSpacer = subview as? FlexibleGroupedSpacer {
                return linkedSpacer
            }
            return nil
        }

        Dictionary(grouping: linkedSpacers) { $0.groupId }.forEach { _, spacerGroup in
            if spacerGroup.count < 2 {
                return
            }
            for idx in (0..<spacerGroup.count - 1) {
                let spacer = spacerGroup[idx]
                let nextSpacer = spacerGroup[idx + 1]
                switch axis {
                case .vertical:
                    spacer.height(equalsToHeightOf: nextSpacer)
                case .horizontal:
                    spacer.width(equalsToWidthOf: nextSpacer)
                @unknown default:
                    break
                }
            }
        }

        return self
    }
}

// MARK: - Handle tap gesture

extension BaseStackView {
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
