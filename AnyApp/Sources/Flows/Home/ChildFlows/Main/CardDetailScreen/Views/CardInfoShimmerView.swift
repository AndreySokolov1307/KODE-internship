import UIKit
import UI
import AppIndependent

final class CardInfoShimmerView: BackgroundPrimary {
    
    // MARK: - Private properties
    
    private let cardView = Shimmer()
        .skeletonCornerRadius(8)
        .height(160)

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack(alignment: .fill, distribution: .fill) {
           cardView
        }
        .layoutMargins(.init(top: 10, left: 24, bottom: 24, right: 24))
    }
}

