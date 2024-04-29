import UIKit
import UI
import AppIndependent
import Services

final class AccountInfoView: BackgroundPrimary {

    // MARK: - Private Properties
    
    private let currencyCircleView = CircleView(sideLenght: 52)
        .backgroundStyle(.contentSecondary)
        .foregroundStyle(.contentAccentTertiary)
    private let accountNameLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body3)
    private let accountNumberLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    private let balanceLabel = Label(foregroundStyle: .textPrimary, fontStyle: .title)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            currencyCircleView
                .image(props.image)
            Spacer(.px16)
            accountNameLabel
                .text(props.accountName)
            Spacer(.px4)
            accountNumberLabel
                .text(props.formattedPhone)
            Spacer(.px8)
            balanceLabel
                .text(props.balanceString)
            Spacer(.px16)
        }
    }
}

// MARK: - Configurable

extension AccountInfoView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: String = UUID().uuidString
        let currency: Currency
        let balance: Int
        let accountNumber: String
        let accountName = Main.AccountDetail.name
        
        var formattedPhone: String {
            String.format(
                accountNumber,
                with: Main.AccountDetail.numberMask,
                replacingChar: "X",
                passingChar: "*")
        }

        public static func == (lhs: AccountInfoView.Props, rhs: AccountInfoView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(currency)
            hasher.combine(accountNumber)
            hasher.combine(balance)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}

extension AccountInfoView.Props {
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
}
