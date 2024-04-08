import UIKit

// swiftlint:disable:next final_class
open class BaseEmptyView: BaseView {

    // MARK: - Init

    public override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }

    // MARK: - Methods to Implement

    override open func setup() {
        backgroundColor = .clear
        setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
    }
}
