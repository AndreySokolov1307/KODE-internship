//
//  AdditionalAccountView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class AccountCardView: BackgroundPrimary {

    // MARK: - Private Properties

    private let nameLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let cardTypeLabel = Label(fontStyle: .caption1)
    private let inputImageView = ImageView(image: Asset.Images.input.image, foregroundStyle: .textTertiary)
        .width(40)
    private let smallCardView = CardView()
        .cornerRadius(2)
        .masksToBounds(true)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            inputImageView
            Spacer(.px16)
            VStack(alignment: .leading, distribution: .fill, spacing: 4) {
                nameLabel
                    .text(props.name)
                cardTypeLabel
                    .text(props.typeText)
                    .foregroundStyle(props.foregroundStyle)
            }
            FlexibleSpacer()
            smallCardView
                .text(props.smallCardText)
                .image(props.smallCardImage)
                .textColor(props.smallCardTextColor)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?()
        }
    }
}

// MARK: - Configurable

extension AccountCardView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: String
        let name: String
        let cardType: Card.CardType
        let status: Card.Status
        let cardNumber: String
        let paymentSystem: Card.PaymentSystem

        var onTap: VoidHandler?

        public static func == (lhs: AccountCardView.Props, rhs: AccountCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(cardType)
            hasher.combine(cardNumber)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}
extension AccountCardView.Props {
    var foregroundStyle: ForegroundStyle {
        switch status {
        case .deactivated:
            return .indicatorContentError
        case .active:
            return .textSecondary
        }
    }
    
    var typeText: String {
        if status == .deactivated {
            return "Заблокирована"
        } else {
            switch cardType {
            case .digital:
                return "Цифровая"
            case .physical:
                return "Физическая"
            }
        }
    }
    
    var smallCardText: String {
        return String(cardNumber.suffix(4))
    }
    
    var smallCardImage: UIImage {
        switch paymentSystem {
        case .visa:
            return Asset.Images.visa.image
        case .masterCard:
            return Asset.Images.masterCard.image
        }
    }
    
    var smallCardTextColor: UIColor {
        switch paymentSystem {
        case .visa:
            return  Palette.Text.secondary
        case .masterCard:
            return .white
        }
    }
}

