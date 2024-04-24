//
//  CurrentAccountView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class CurrentAccountView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary)
        .text(Main.currentAccount)
    private let moneyLabel = Label()
        .multiline()
    private let currencyImageView = ImageView(foregroundStyle: .contentPrimary)
    private let cardImageView = ImageView(image: Asset.Images.chevronUp.image, foregroundStyle: .textTertiary)
        .size(width: 40, height: 28)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill) {
                currencyImageView
                    .image(props.image)
            Spacer(.px16)
            VStack(alignment: .leading, distribution: .fill, spacing: 4) {
                titleLabel
                moneyLabel
                    .text(props.balance + Common.space + props.sign)
                    .textColor(props.textColor)
            }
            FlexibleSpacer()
            BackgroundView {
                cardImageView
            }
            .backgroundStyle(.contentSecondary)
            .cornerRadius(2)
            .masksToBounds(true)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension CurrentAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: Int
        let balance: String
        let currency: Account.Currency

        var onTap: IntHandler?

        public static func == (lhs: CurrentAccountView.Props, rhs: CurrentAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(balance)
            hasher.combine(currency)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
extension CurrentAccountView.Props {
    var textColor: UIColor {
        if balance.first != "-" {
            return Palette.Content.accentPrimary
        } else {
            return Palette.Indicator.contentError
        }
    }

    var image: UIImage {
        switch currency {
        case .rub:
            return Asset.Images.ruble.image
        case .eur:
            return Asset.Images.dollar.image
        case .usd:
            return Asset.Images.euro.image
        }
    }
    
    var sign: String {
        switch currency {
        case .rub:
            return "₽"
        case .eur:
            return "€"
        case .usd:
            return "$"
        }
    }
}
