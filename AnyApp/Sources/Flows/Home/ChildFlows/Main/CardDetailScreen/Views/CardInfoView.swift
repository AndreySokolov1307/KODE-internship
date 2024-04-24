//
//  CardInfoView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//

import UIKit
import UI
import AppIndependent

final class CardInfoView: View {
    
    private let cardNameLabel = Label(fontStyle: .body2)
        .textColor(Asset.Colors.alwaysWhite.color)
    private let cardTypeLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption2)
    private let cardBalanceLabel = Label(fontStyle: .subtitle2)
        .textColor(Asset.Colors.alwaysWhite.color)
    private let cardNumberLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    private let cardClosingDateLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    private let paymentSystemImageView = ImageView()
        .size(CGSize(width: 32, height: 24))
    private let payPassImageView = ImageView(image: Asset.Images.payPass.image)
    private let backgroundImageView = ImageView(image: Asset.Images.cardGrayBGBig.image)
        .contentMode(.scaleToFill)
        .height(160)
        .cornerRadius(8)
        .masksToBounds(true)
    
    private var props: Props?
    
    override func setup() {
        super.setup()
    }
    
    private func body(with props: Props) -> UIView {
        HStack {
            View().embed(subview: backgroundImageView.embed(subview: foregroundBody(with: props)))
            .shadowStyle(.card)
        }.layoutMargins(.init(top: 0, left: 24, bottom: 24, right: 24))
    }
    
    private func foregroundBody(with props: Props) -> UIView {
        VStack(alignment: .fill, distribution: .equalSpacing) {
            HStack(alignment: .center, distribution: .fill, spacing: 16) {
                paymentSystemImageView
                    .image(props.paymentSystemImage)
                VStack(alignment: .leading, distribution: .fill, spacing: 4) {
                    cardNameLabel
                        .text(props.cardNumberText)
                    cardTypeLabel
                        .text(props.typeText)
                }
                payPassImageView
            }
            cardBalanceLabel
                .text(props.balance)
            HStack {
                cardNumberLabel
                    .text(props.cardNumberText)
                FlexibleSpacer()
                cardClosingDateLabel
                    .text(props.closingDate.formatted())
            }
        }
        .layoutMargins(.init(top: 20, left: 16, bottom: 24, right: 16))
    }
}

extension CardInfoView: ConfigurableView {

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
        let balance: String
        let isBlocked: Bool
        let cardNumber: String
        let paymentSystem: PaymentSystem
        let closingDate: Date

        var onTap: StringHandler?

        public static func == (lhs: CardInfoView.Props, rhs: CardInfoView.Props) -> Bool {
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
extension CardInfoView.Props {
    var textColor: UIColor {
        if isBlocked {
            return Palette.Indicator.contentError
        } else {
            return Palette.Text.secondary
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
    
    var cardNumberText: String {
        return String(cardNumber.suffix(8))
    }
    
    var paymentSystemImage: UIImage {
        switch paymentSystem {
        case .visa:
            return Asset.Images.visa.image
        case .masterCard:
            return Asset.Images.masterCard.image
        }
    }
}
