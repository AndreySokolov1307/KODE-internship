import UIKit
import UI
import AppIndependent

final class InfoView: BackgroundPrimary {

    // MARK: - Private Properties

    private let infoLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let infoImageView = ImageView(foregroundStyle: .textTertiary)
    private let accessoryImageView = ImageView(foregroundStyle: .textTertiary)
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            infoImageView
                .image(props.image)
            Spacer(.px16)
            infoLabel
                .text(props.title)
            FlexibleSpacer()
            accessoryImageView
                .image(props.accessoryType.image)
                .isHidden(!props.hasAccessory)
        }
        .height(56)
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?()
        }
    }
}

// MARK: - Configurable

extension InfoView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum AccessoryType {
            case down
            case right
        }
        
        let id: String = UUID().uuidString
        let title: String
        let image: UIImage
        var hasAccessory = false
        var accessoryType: AccessoryType = .right
        var onTap: VoidHandler?

        public static func == (lhs: InfoView.Props, rhs: InfoView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}

extension InfoView.Props.AccessoryType {
    var image: UIImage {
        switch self {
        case .down:
            return Asset.Images.chevronDown.image
        case .right:
            return Asset.Images.chevronRight.image
        }
    }
}
