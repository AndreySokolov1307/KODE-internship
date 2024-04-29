import Foundation

import UIKit
import UI
import AppIndependent

final class HeaderShimmerView: BackgroundPrimary {
    
    // MARK: - Private Properties
    
    private let headerView = Shimmer()
        .size(width: 72, height: 14)
        .skeletonCornerRadius(8)

    // MARK: - Public Methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private Methods

    private func body() -> UIView {
        HStack(alignment: .center) {
            headerView
            FlexibleSpacer()
        }
        .layoutMargins(.make(hInsets: 16))
        .height(52)
    }
}
