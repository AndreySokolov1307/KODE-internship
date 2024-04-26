//
//  ProfileDetailView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 14.04.2024.
//

import UIKit
import UI
import AppIndependent

final class ProfileDetailView: BackgroundPrimary {

    // MARK: - Private Properties
    
    private let avatarImageView = ImageView()
        .size(width: 88, height: 88)
        .cornerRadius(44)
        .masksToBounds(true)
    private let nameLabel = Label(foregroundStyle: .textPrimary, fontStyle: .subtitle2)
    private let phoneNumberLabel = Label(foregroundStyle: .textSecondary, fontStyle: .caption2)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        
        VStack(alignment: .center, distribution: .fill) {
            avatarImageView
                .image(props.avatarImage)
            Spacer(.px16)
            nameLabel
                .text(props.name)
            Spacer(.px4)
            phoneNumberLabel
                .text(props.formattedPhone)
            Spacer(length: 50)
        }
    }
}

// MARK: - Configurable

extension ProfileDetailView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String = UUID().uuidString
        let avatarImage: UIImage
        let name: String
        let phoneNumber: String
        
        var formattedPhone: String {
            String.format(
                phoneNumber,
                with: "+X (XXX) *** - ** - XX",
                replacingChar: "X",
                passingChar: "*")
        }
    
        public static func == (lhs: ProfileDetailView.Props, rhs: ProfileDetailView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(phoneNumber)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}

