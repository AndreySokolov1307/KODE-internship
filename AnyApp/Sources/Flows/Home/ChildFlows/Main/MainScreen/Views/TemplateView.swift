//
//  TemplateView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary)
    private let descriptionLabel = Label(foregroundStyle: .textPrimary)
        .multiline()

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        cornerRadius(16)
        //borderStyle(.template, width: 1)
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack {
            titleLabel
                .text(props.title)
            descriptionLabel
                .text(props.description)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 12))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable

extension TemplateView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String

        var onTap: StringHandler?

        public static func == (lhs: TemplateView.Props, rhs: TemplateView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}

