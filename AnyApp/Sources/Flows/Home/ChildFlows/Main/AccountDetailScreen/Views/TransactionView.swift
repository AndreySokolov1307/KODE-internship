import UIKit
import UI
import AppIndependent
import Services

final class TransactionView: BackgroundPrimary {
    
    // MARK: - Private Properties

    private let circleView = CircleView(sideLenght: 40)
        .backgroundStyle(.contentSecondary)
        .foregroundStyle(.contentAccentPrimary)
    private let dateLabel = Label(foregroundStyle: .textTertiary, fontStyle: .caption1)
    private let balanceLabel = Label(fontStyle: .body2)
    private let infoLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
        .multiline()
    
    private var props: Props?

    // MARK: - Public Methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private Methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .top, distribution: .fill, spacing: 16) {
            circleView
                .image(props.type.image)
            VStack(spacing: 4) {
                HStack(alignment: .firstBaseline, distribution: .fill) {
                    dateLabel
                        .text(props.dateString)
                    FlexibleSpacer()
                    balanceLabel
                        .text(props.balanceString)
                        .foregroundStyle(props.balanceForgroundStyle)
                }
                infoLabel
                    .text(props.info)
            }
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension TransactionView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum TransactionType {
            case payment
            case transfer
        }
        
        let id: String = UUID().uuidString
        let type: TransactionType
        let currency: Currency = .rub
        let transaction: Double
        let info: String
        let date: Date

        var onTap: StringHandler?

        public static func == (lhs: TransactionView.Props, rhs: TransactionView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(transaction)
            hasher.combine(type)
            hasher.combine(info)
            hasher.combine(date)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}

extension TransactionView.Props {
    var balanceForgroundStyle: ForegroundStyle {
        if String(transaction).first != "-" {
            return .indicatorContentDone
        } else {
            return .indicatorContentError
        }
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.format = .dayTime
        return dateFormatter.string(from: date)
    }
    
    var balanceString: String {
        let string = transaction.formatted(.currency(code: currency.rawValue))
        if String(transaction).first != "-" {
            return "+\(string)"
        } else {
            return string
        }
    }
}

extension TransactionView.Props.TransactionType {
    var image: UIImage {
        switch self {
        case .payment:
            return Asset.Images.payment.image
        case .transfer:
            return Asset.Images.transfer.image
        }
    }
}
