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

final class AccountView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
        .text(Main.currentAccount)
    private let balanceLabel = Label(fontStyle: .body2)
        .multiline()
    private let currencyCircleView = CircleView(sideLenght: 40)
        .backgroundStyle(.contentSecondary)
        .foregroundStyle(.contentAccentTertiary)
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
                currencyCircleView
                    .image(props.image)
            Spacer(.px16)
            VStack(alignment: .leading, distribution: .fill, spacing: 4) {
                titleLabel
                balanceLabel
                    .text(props.balanceString)
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
            self?.props?.onTap?()
        }
    }
}

// MARK: - Configurable

extension AccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: Int
        let balance: Int
        let currency: Currency

        var onTap: VoidHandler?

        public static func == (lhs: AccountView.Props, rhs: AccountView.Props) -> Bool {
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
        self.layoutIfNeeded()
    }
}
extension AccountView.Props {
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
            return Asset.Images.rub.image
        case .eur:
            return Asset.Images.usd.image
        case .usd:
            return Asset.Images.eur.image
        }
    }
    
    var balanceString: String {
        balance.formatted(.currency(code: currency.rawValue))
    }
}
