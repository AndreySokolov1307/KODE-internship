//
//  InfoView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 14.04.2024.
//

import UIKit
import UI
import AppIndependent

final class InfoView: BackgroundPrimary {

    // MARK: - Private Properties

    private let infoLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    private let infoImageView = ImageView()
    private let accessoryImageView = ImageView(image: Asset.Images.chevronRight.image)
    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            infoImageView
                .image(props.infoType.image)
            Spacer(.px16)
            infoLabel
                .text(props.infoType.title)
            FlexibleSpacer()
            accessoryImageView
                .isHidden(!props.infoType.hasAccessory)
        }
        .height(56)
        .layoutMargins(.make(vInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?()
        }
    }
}

// MARK: - Configurable

extension InfoView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum InfoType {
            case about
            case theme
            case support
            case logOut
        }
        
        let id: String = UUID().uuidString
        let infoType: InfoType

        var onTap: VoidHandler?

        public static func == (lhs: InfoView.Props, rhs: InfoView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(infoType)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

extension InfoView.Props.InfoType {
    var image: UIImage {
        switch self {
        case .about:
            return Asset.Images.settings.image
        case .theme:
            return Asset.Images.moon.image
        case .support:
            return Asset.Images.phoneCall.image
        case .logOut:
            return Asset.Images.quit.image
        }
    }
    
    var title: String {
        switch self {
        case .about:
            return Profile.about
        case .theme:
            return Profile.theme
        case .support:
            return Profile.support
        case .logOut:
            return Profile.logOut
        }
    }
    
    var hasAccessory: Bool {
        switch self {
        case .about, .theme:
            return true
        case .support, .logOut:
            return false
        }
    }
}
