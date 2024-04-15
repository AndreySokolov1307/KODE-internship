//
//  AccountShimmerView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 15.04.2024.
//

import UIKit
import UI
import AppIndependent

final class AccountShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let imageView = Shimmer()
        .size(width: 40, height: 40)
        .skeletonCornerRadius(20)
    private let titleView = Shimmer()
        .height(16)
        .skeletonCornerRadius(8)
    private let subtitleView = Shimmer()
        .height(12)
        .skeletonCornerRadius(6)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack(alignment: .center) {
            imageView
            Spacer(.px16)
            VStack(spacing: 8) {
                titleView
                HStack {
                    subtitleView
                    Spacer(length: 100)
                }
            }
            .layoutMargins(.make(vInsets: 3))
        }
        .layoutMargins(.make(vInsets: 8, hInsets: 16))
        .height(72)
    }
}
