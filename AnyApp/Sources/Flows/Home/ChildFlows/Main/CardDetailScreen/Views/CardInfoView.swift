import UIKit
import UI
import AppIndependent
import Services

final class CardInfoView: View {
    
    private let cardNameLabel = Label(fontStyle: .body2)
        .textColor(Asset.Colors.alwaysWhite.color)
    private let cardTypeLabel = Label(fontStyle: .caption2)
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
        }.layoutMargins(.init(top: 10, left: 24, bottom: 24, right: 24))
    }
    
    private func foregroundBody(with props: Props) -> UIView {
        VStack(alignment: .fill, distribution: .equalSpacing) {
            HStack(alignment: .center, distribution: .fill, spacing: 16) {
                paymentSystemImageView
                    .image(props.paymentSystemImage)
                VStack(alignment: .leading, distribution: .fill, spacing: 4) {
                    cardNameLabel
                        .text(props.name)
                    cardTypeLabel
                        .text(props.typeText)
                        .foregroundStyle(props.typeForgroundStyle)
                }
                payPassImageView
            }
            cardBalanceLabel
                .text(props.balanceString)
            HStack {
                cardNumberLabel
                    .text(props.cardNumberText)
                FlexibleSpacer()
                cardClosingDateLabel
                    .text(props.expiredAtString)
            }
        }
        .layoutMargins(.init(top: 20, left: 16, bottom: 24, right: 16))
    }
}

extension CardInfoView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: Int
        let name: String
        let cardType: Card.CardType = .digital
        let status: CoreCardResponse.Status
        let balance: Int = 56800
        let currency: Currency = .rub
        let number: String
        let paymentSystem: CoreCardResponse.PaymentSystem
        let expiredAt: String

        var onTap: StringHandler?

        public static func == (lhs: CardInfoView.Props, rhs: CardInfoView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(number)
            hasher.combine(expiredAt)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}
extension CardInfoView.Props {
    var typeForgroundStyle: ForegroundStyle {
        switch status {
        case .active:
            return .textSecondary
        case .deactivated:
            return .indicatorContentError
        }
    }
    
    var typeText: String {
        if status != .active {
            return "заблокирована"
        } else {
            switch cardType {
            case .digital:
                return "виртуальная"
            case .physical:
                return "физическая"
            }
        }
    }
    
    var cardNumberText: String {
        let number = String(self.number.suffix(8))
        
        return String.format(
            number,
            with: "**** XXXX",
            replacingChar: "X",
            passingChar: "*")
    }
    
    var paymentSystemImage: UIImage {
        switch paymentSystem {
        case .visa:
            return Asset.Images.visa.image
        case .masterCard:
            return Asset.Images.masterCard.image
        }
    }
    
    var expiredAtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.format = .iso
        guard let date = dateFormatter.date(from: expiredAt) else { return  " " }
        dateFormatter.format = .monthYearShort
        return dateFormatter.string(from: date)
    }
    
    var balanceString: String {
        balance.formatted(.currency(code: currency.rawValue))
    }
}

