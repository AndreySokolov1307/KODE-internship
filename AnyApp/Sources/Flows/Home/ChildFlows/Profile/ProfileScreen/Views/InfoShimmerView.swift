//
//  InfoShimmerView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 13.04.2024.
//

import UIKit
import UI
import AppIndependent

final class InfoShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let imageView = Shimmer()
        .size(width: 40, height: 40)
        .skeletonCornerRadius(20)
    private let infoView = Shimmer()
        .height(16)
        .skeletonCornerRadius(8)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            imageView
            Spacer(.px16)
            infoView
        }
        .layoutMargins(.make(hInsets: 16))
        .height(56)
    }
}
