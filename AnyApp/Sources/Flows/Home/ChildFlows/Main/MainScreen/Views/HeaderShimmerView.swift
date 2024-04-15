//
//  HeaderShimmerView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 15.04.2024.
//

import Foundation

import UIKit
import UI
import AppIndependent

final class HeaderShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let headerView = Shimmer()
        .size(width: 72, height: 14)
        .skeletonCornerRadius(8)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack(alignment: .center) {
            headerView
            FlexibleSpacer()
        }
        .layoutMargins(.make(hInsets: 16))
        .height(52)
    }
}
