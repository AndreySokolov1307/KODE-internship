import UI
import UIKit
import SkeletonView

final class InfoTabShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let leftTabView = Shimmer()
        .size(width: 56, height: 56)
        .skeletonCornerRadius(28)
    private let rightTabView = Shimmer()
        .size(width: 56, height: 56)
        .skeletonCornerRadius(28)
    private let middleTabView = Shimmer()
        .size(width: 56, height: 56)
        .skeletonCornerRadius(28)
   
    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        return HStack(distribution: .equalSpacing) {
            leftTabView
            middleTabView
            rightTabView
        }.layoutMargins(.make(vInsets: 16, hInsets: 36))
    }
}
