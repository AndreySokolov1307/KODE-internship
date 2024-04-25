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

    private let depositNameLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let moneyLabel = Label(fontStyle: .body2 )
    private let currencyCircleView = CircleView(sideLenght: 40)
        .backgroundStyle(.contentSecondary)
        .foregroundStyle(.contentAccentTertiary)
    private let interestRateLabel = Label(foregroundStyle: .textTertiary)
        .fontStyle(.caption2)
    private let dueDateLabel = Label(foregroundStyle: .textTertiary)
        .fontStyle(.caption2)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .fill, distribution: .fill) {
            currencyCircleView
                .image(props.image)
            Spacer(.px16)
            VStack(alignment: .fill, distribution: .fill, spacing: 4) {
                HStack(alignment: .fill, distribution: .fill) {
                    depositNameLabel
                        .text(props.name)
                    FlexibleSpacer()
                    interestRateLabel
                        .text("Ставка" + Common.space + String(props.interestRate) + "%")
                }
                HStack(alignment: .fill, distribution: .fill) {
                    moneyLabel
                        .text(props.balanceString)
                        .foregroundStyle(props.foregroundStyle)
                    FlexibleSpacer()
                    dueDateLabel
                        .text("до" + Common.space + props.dateString)
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
        self.layoutIfNeeded()
    }
}

extension DepostiView.Props {
    var foregroundStyle: ForegroundStyle {
        if String(balance).first != "-" {
            return .contentAccentPrimary
        } else {
            return .indicatorContentError
        }
    }

    var image: UIImage {
        switch currency {
        case .rub:
            return Asset.Images.rub.image
        case .usd:
            return Asset.Images.usd.image
        case .eur:
            return Asset.Images.eur.image
        }
    }
    
    var balanceString: String {
        balance.formatted(.currency(code: currency.rawValue))
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.format = .dayMonthYear
        return dateFormatter.string(from: closingDate)
    }
}
