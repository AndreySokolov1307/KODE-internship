import Foundation

import UIKit
import UI
import AppIndependent

final class PaymentView: BackgroundPrimary {

    // MARK: - Private Properties
    
    private let circleImageView = CircleView(sideLenght: 40)
        .backgroundStyle(.contentSecondary)
        .foregroundStyle(.contentAccentPrimary)
    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private var props: Props?

    // MARK: - Public Methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private Methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
            circleImageView.image(props.image)
            titleLabel.text(props.title)
        }
        .height(68)
        .layoutMargins(.make(hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?()
        }
    }
}

// MARK: - Configurable

extension PaymentView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: String = UUID().uuidString
        let title: String
        let image: UIImage
        var onTap: VoidHandler?

        public static func == (lhs: PaymentView.Props, rhs: PaymentView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
