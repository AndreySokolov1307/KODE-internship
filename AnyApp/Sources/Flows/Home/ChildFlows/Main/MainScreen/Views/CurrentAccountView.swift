//
//  CurrentAccountView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent

final class CurrentAccountView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary)
        .text(Main.currentAccount)
    private let moneyLabel = Label(foregroundStyle: .textPrimary)
        .multiline()
    private let currencyImageView = ImageView(foregroundStyle: .contentPrimary)
    private let cardImageView = ImageView(image: Asset.chevronDown.image)
        .size(width: 40, height: 28)
        .cornerRadius(2)
        .backgroundColor(Palette.Content.primary)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            currencyImageView
                .image(props.currency.image)
            Spacer(.px16)
            VStack(alignment: .leading, distribution: .fill, spacing: 4) {
                titleLabel
                moneyLabel
                    .text(props.money + " " + props.currency.sign)
                    .textColor(props.textColor)
            }
            FlexibleSpacer()
            cardImageView
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
        
        enum Currency {
            case ruble
            case euro
            case dollar
        }
        
        let id: String = UUID().uuidString
        let money: String
        let currency: Currency

        var onTap: StringHandler?

        public static func == (lhs: CurrentAccountView.Props, rhs: CurrentAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(money)
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
        if money.first != "-" {
            return Palette.Content.contentAccentPrimary
        } else {
            return Asset.indicatorContentError.color
        }
    }
}

extension CurrentAccountView.Props.Currency {
    var image: UIImage {
        switch self {
        case .ruble:
            return Asset.ruble.image
        case .euro:
            return Asset.dollar.image
        case .dollar:
            return Asset.euro.image
        }
    }
    
    var sign: String {
        switch self {
        case .ruble:
            return "₽"
        case .euro:
            return "€"
        case .dollar:
            return "$"
        }
    }
}
