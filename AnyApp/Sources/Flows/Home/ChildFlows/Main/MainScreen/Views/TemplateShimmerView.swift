//
//  TemplateShimmerView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateShimmerView: BackgroundPrimary {

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        BackgroundView {
            VStack {
                Shimmer()
            }
            .layoutMargins(.make(vInsets: 8, hInsets: 16))
        }
        .height(72)
    }
}
//
//extension TemplateShimmerView: ConfigurableView {
//
//    typealias Model = Props
//
//    struct Props {
//        let height: CGFloat
//    }
//
//    func configure(with model: Props) {
//        subviews.forEach { $0.removeFromSuperview() }
//        body(props: model).embed(in: self)
//    }
//}

