//
//  ProfileInfoShimmerView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 13.04.2024.
//

import UI
import UIKit
import SkeletonView

final class ProfileInfoShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let avatarView = Shimmer()
        .size(width: 88, height: 88)
        .skeletonCornerRadius(44)
    private let nameView = Shimmer()
        .size(width: 256, height: 18)
        .skeletonCornerRadius(8)
    private let numberView = Shimmer()
        .size(width: 122, height: 16)
        .skeletonCornerRadius(8)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            avatarView
            Spacer(.px20)
            nameView
            Spacer(.px4)
            numberView
            Spacer(length: 45)
        }
    }
}
