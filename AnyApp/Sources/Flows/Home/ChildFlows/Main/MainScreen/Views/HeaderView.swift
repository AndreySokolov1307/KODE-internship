import UIKit
import UI
import AppIndependent

final class HeaderView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textTertiary, fontStyle: .body3)

    private var props: Props?

    // MARK: - Public Methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private Methods

    private func body() -> UIView {
        VStack {
            titleLabel
        }
        .layoutMargins(.all(16))
    }
}

// MARK: - Configurable

extension HeaderView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let title: String

        public static func == (lhs: HeaderView.Props, rhs: HeaderView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        titleLabel.text(model.title)
        self.layoutIfNeeded()
    }
}

