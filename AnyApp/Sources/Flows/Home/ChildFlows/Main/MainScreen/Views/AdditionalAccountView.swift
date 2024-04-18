//
//  AdditionalAccountView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent

final class AdditionalAccountView: BackgroundPrimary {

    // MARK: - Private Properties

    private let purposeLabel = Label(foregroundStyle: .textPrimary)
    private let cardTypeLabel = Label(foregroundStyle: .textPrimary)
        .fontStyle(.caption1)
    private let inputImageView = ImageView(image: Asset.Images.input.image, foregroundStyle: .textTertiary)
        .width(40)
    private let smallCardView = CardView()
        .cornerRadius(2)

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
                purposeLabel
                    .text(props.purposeText)
                cardTypeLabel
                    .text(props.typeText)
                    .textColor(props.textColor)
            }
            FlexibleSpacer()
            smallCardView
                .text(props.smallCardText)
                .image(props.smallCardImage)
                .textColor(props.smallCardTextColor)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension AdditionalAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum CardType {
            case physical
            case digital
        }
        
        enum CardPurpose {
            case salary
            case extra
        }
        
        enum PaymentSystem {
            case visa
            case masterCard
        }
        
        let id: String = UUID().uuidString
        let cardType: CardType
        let cardPurpose: CardPurpose
        let isBlocked: Bool
        let cardNumber: String
        let paymentSystem: PaymentSystem

        var onTap: StringHandler?

        public static func == (lhs: AdditionalAccountView.Props, rhs: AdditionalAccountView.Props) -> Bool {
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
    }
}
extension AdditionalAccountView.Props {
    var textColor: UIColor {
        if isBlocked {
            return Palette.Indicator.contentError
        } else {
            return Palette.Text.secondary
        }
    }
    
    var purposeText: String {
        switch cardPurpose {
        case .salary:
            return "Карта зарплатная"
        case .extra:
            return "Дополнительная карта"
        }
    }
    
    var typeText: String {
        if isBlocked {
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

