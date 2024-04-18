//
//  AccountMainInfoView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import UIKit
import UI
import AppIndependent

final class AccountInfoView: BackgroundPrimary {

    // MARK: - Private Properties
    
    private let currencyImageView = ImageView()
        .size(width: 52, height: 52)
        .cornerRadius(26)
        .masksToBounds(true)
    private let accountNameLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body3)
    private let accountNumberLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    private let moneyLabel = Label(foregroundStyle: .textPrimary, fontStyle: .title)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            currencyImageView
                .image(props.currency.image)
            Spacer(.px16)
            accountNameLabel
                .text(props.accountName)
            Spacer(.px4)
            accountNumberLabel
                .text(props.accountNumber)
            Spacer(.px8)
            moneyLabel
                .text(props.money + Common.space + props.currency.sign)
            Spacer(.px16)
        }
    }
}

// MARK: - Configurable

extension AccountInfoView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum Currency {
            case ruble
            case euro
            case dollar
        }
        
        let id: String = UUID().uuidString
        let currency: Currency
        let money: String
        let accountNumber: String
        let accountName = "Счет расчетный"

        public static func == (lhs: AccountInfoView.Props, rhs: AccountInfoView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(currency)
            hasher.combine(accountNumber)
            hasher.combine(money)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

extension AccountInfoView.Props.Currency {
    var image: UIImage {
        switch self {
        case .ruble:
            return Asset.Images.ruble.image
        case .euro:
            return Asset.Images.dollar.image
        case .dollar:
            return Asset.Images.euro.image
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
