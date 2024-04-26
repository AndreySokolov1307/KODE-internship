import UI
import UIKit
import SkeletonView

final class AccountInfoShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let currencyView = Shimmer()
        .size(width: 52, height: 52)
        .skeletonCornerRadius(26)
    private let accountNameView = Shimmer()
        .size(width: 120, height: 16)
        .skeletonCornerRadius(8)
    private let accountNumberView = Shimmer()
        .size(width: 144, height: 14)
        .skeletonCornerRadius(7)
    private let balanceView = Shimmer()
        .size(width: 175, height: 24)
        .skeletonCornerRadius(12)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            currencyView
            Spacer(.px16)
            accountNameView
            Spacer(.px8)
            accountNumberView
            Spacer(.px16)
            balanceView
            Spacer(.px24)
        }
    }
}

