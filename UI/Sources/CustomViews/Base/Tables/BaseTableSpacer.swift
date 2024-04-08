import Foundation

// swiftlint:disable:next final_class
public class BaseTableSpacer: BaseView, ConfigurableView {

    // MARK: - Typealiases

    public typealias Model = Props

    // MARK: - Types

    public struct Props: Hashable {
        public let id = UUID()
        public let height: CGFloat

        public init(height: CGFloat) {
            self.height = height
        }
    }

    // MARK: - Public Methods

    public func configure(with model: Model) {
        subviews.forEach { $0.removeFromSuperview() }
        BaseView().height(model.height).embed(in: self)
    }
}
