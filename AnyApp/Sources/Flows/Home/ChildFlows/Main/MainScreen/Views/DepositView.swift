//
//  DepositView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class DepostiView: BackgroundPrimary {
    
    // MARK: - Private Properties

    private let depositNameLabel = Label(foregroundStyle: .textPrimary)
    private let moneyLabel = Label()
    private let currencyImageView = ImageView(foregroundStyle: .contentPrimary)
    private let interestRateLabel = Label(foregroundStyle: .textSecondary)
        .fontStyle(.caption2)
    private let dueDateLabel = Label(foregroundStyle: .textSecondary)
        .fontStyle(.caption2)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .fill, distribution: .fill) {
            currencyImageView
                .image(props.image)
            Spacer(.px16)
            VStack(alignment: .fill, distribution: .fill, spacing: 4) {
                HStack(alignment: .fill, distribution: .fill) {
                    depositNameLabel
                        .text(props.name)
                    FlexibleSpacer()
                    interestRateLabel
                        .text("Ставка " + String(props.interestRate) + "%")
                }
                HStack(alignment: .fill, distribution: .fill) {
                    moneyLabel
                        .text("\(props.balance)" + Common.space + props.sign)
                        .textColor(props.textColor)
                    FlexibleSpacer()
                    dueDateLabel
                        .text("до " + props.closingDate.formatted())
                }
            }
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?()
        }
    }
}

// MARK: - Configurable

extension DepostiView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: Int
        let name: String
        let status: Deposit.Status
        let currency: Deposit.Currency
        let balance: Int
        let interestRate: Double
        let closingDate: Date

        var onTap: VoidHandler?

        public static func == (lhs: DepostiView.Props, rhs: DepostiView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(balance)
            hasher.combine(closingDate)
            hasher.combine(name)
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
        if String(balance).first != "-" {
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
