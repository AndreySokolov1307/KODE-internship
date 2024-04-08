import UIKit

// swiftlint:disable:next final_class
open class BaseGradientView: BaseView {

    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }

    public private(set) var gradient: GradientProps?

    private func draw(gradient: GradientProps?) {
        gradientLayer?.apply(gradientProps: gradient)
    }

    @discardableResult
    public func gradient(_ gradient: GradientProps?) -> Self {
        self.gradient = gradient
        draw(gradient: gradient)
        return self
    }

    override open func updateAppearance() {
        super.updateAppearance()
        draw(gradient: gradient)
    }
}

public extension CAGradientLayer {

    func apply(gradientProps: GradientProps?) {
        guard let gradient = gradientProps else {
            // remove gradient background
            colors = nil
            locations = nil
            return
        }

        // set gradient background
        startPoint = gradient.direction.startPoint
        endPoint = gradient.direction.endPoint

        if let locations = gradient.locations {
            self.locations = locations.map { $0 as NSNumber }
        } else {
            locations = nil
        }
        colors = gradient.colors.map(\.cgColor)
    }
}
