import UIKit.UIView
import SkeletonView

// swiftlint:disable:next final_class
open class Shimmer: View {

    public enum Style {
        case `default`

        var gradient: SkeletonGradient {
            switch self {
            case .default:
                return Palette.Gradient.skeleton
            }
        }
    }

    private var style: Style = .default

    public convenience init(style: Style) {
        self.init()
        self.style = style
    }

    override open func setup() {
        super.setup()
        isSkeletonable = true
        skeletonCornerRadius = Constant.defaultCornerRadius
        backgroundColor = .clear
    }

    override open func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: window)
        updateAppearance()
    }

    override open func updateAppearance() {
        super.updateAppearance()
        DispatchQueue.main.async {
            if self.sk.isSkeletonActive {
                self.updateShimmering()
            } else {
                self.startShimmering()
            }
        }
    }
}

// MARK: - Public Methods

public extension Shimmer {

    @discardableResult
    func skeletonCornerRadius(_ radius: Float) -> Self {
        skeletonCornerRadius = radius
        return self
    }

    func startShimmering() {
        showAnimatedGradientSkeleton(usingGradient: style.gradient)
    }

    func updateShimmering() {
        updateAnimatedGradientSkeleton(usingGradient: style.gradient)
    }
}

// MARK: - Constant

private extension Shimmer {
    enum Constant {
        static let defaultCornerRadius: Float = 16
    }
}
