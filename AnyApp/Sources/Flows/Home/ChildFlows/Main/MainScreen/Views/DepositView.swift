//
//  DepositView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent

final class DepostiView: BackgroundPrimary {
    
    // MARK: - Private Properties

    private let depositNameLabel = Label(foregroundStyle: .textPrimary)
    private let moneyLabel = Label(foregroundStyle: .textPrimary)
    private let currencyImageView = ImageView(foregroundStyle: .contentPrimary)
    private let interestRateLabel = Label(foregroundStyle: .textSecondary)
    private let dueDateLabel = Label(foregroundStyle: .textSecondary)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        cornerRadius(16)
        //borderStyle(.template, width: 1)
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .fill, distribution: .fill) {
            currencyImageView
                .image(props.currency.image)
            Spacer(.px16)
            VStack(alignment: .fill, distribution: .fill, spacing: 4) {
                HStack(alignment: .fill, distribution: .fill) {
                    depositNameLabel
                        .text(props.type.title)
                    FlexibleSpacer()
                    interestRateLabel
                        .text("Ставка " + String(props.interestRate) + "%")
                        .fontStyle(.caption2)
                }
                HStack(alignment: .fill, distribution: .fill) {
                    moneyLabel
                        .text(props.money + " " + props.currency.sign)
                        .textColor(props.textColor)
                    FlexibleSpacer()
                    dueDateLabel
                        .text("до " + props.dueDate.formatted())
                        .fontStyle(.caption2)
                }
            }
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 12))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension DepostiView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum DepositType {
            case main
            case saving
            case currency(Currency)
           
            enum Currency {
                case ruble
                case euro
                case dollar
            }
        }
        
        let id: String = UUID().uuidString
        let type: DepositType
        let currency: DepositType.Currency
        let money: String
        let interestRate: Double
        let dueDate: Date

        var onTap: StringHandler?

        public static func == (lhs: DepostiView.Props, rhs: DepostiView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(money)
            hasher.combine(dueDate)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

extension DepostiView.Props {
    var textColor: UIColor {
        if money.first != "-" {
            return Palette.Content.contentAccentPrimary
        } else {
            return Asset.indicatorContentError.color
        }
    }
}

extension DepostiView.Props.DepositType {
    var title: String {
        switch self {
        case .main:
            return "Мой вклад"
        case .saving:
            return "Накопительный"
        case .currency(let currency):
            switch currency {
            case .ruble:
                return "RUB вклад"
            case .dollar:
                return "USD вклад"
            case .euro:
                return "EUR вклад"
            }
        }
    }
}

extension DepostiView.Props.DepositType.Currency {
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
