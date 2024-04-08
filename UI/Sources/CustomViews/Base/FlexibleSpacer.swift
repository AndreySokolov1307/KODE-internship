import UIKit

/// Flexible spacer which tries to fill all available space
public class FlexibleSpacer: BaseView {
// swiftlint:disable:previous final_class

    // MARK: - Init

    public convenience init(matchingHeightOf matchView: UIView, withMultiplier multiplier: CGFloat) {
        self.init()
        snp.makeConstraints { $0.height.equalTo(matchView).multipliedBy(multiplier) }
    }

    convenience init(minHeight: CGFloat? = nil, maxHeight: CGFloat? = nil) {
        self.init()
        setContentHuggingPriority(.defaultLow, for: .vertical)
        setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        if let minHeight {
            self.snp.makeConstraints { $0.height.greaterThanOrEqualTo(minHeight) }
        }
        if let maxHeight {
            self.snp.makeConstraints { $0.height.lessThanOrEqualTo(maxHeight).priority(.low) }
        }
    }

    public convenience init(minWidth: CGFloat? = nil, maxWidth: CGFloat? = nil) {
        self.init()
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        if let minWidth {
            self.snp.makeConstraints { $0.width.greaterThanOrEqualTo(minWidth) }
        }
        if let maxWidth {
            self.snp.makeConstraints { $0.width.lessThanOrEqualTo(maxWidth).priority(.low) }
        }
    }

    // MARK: - Public Methods

    override public func setup() {
        super.setup()

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1), for: .vertical)
    }
}

/// Flexible spacer, which creates a group along with other spacers with the same `groupId`. `BaseStackView` would make equal height/width constraints according to it's axis
public final class FlexibleGroupedSpacer: FlexibleSpacer {

    public let groupId: UInt

    public init(groupId: UInt = 0) {
        self.groupId = groupId
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        groupId = 0
        super.init(frame: .zero)
    }
}
