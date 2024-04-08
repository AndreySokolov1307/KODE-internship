// swiftlint:disable:next final_class
open class GradientView: BaseGradientView {

    private var gradientStyle: GradientStyle = .none
    private var backgroundStyle: BackgroundStyle = .none

    override open func updateAppearance() {
        gradient(gradientStyle.gradientProps)
        backgroundColor(backgroundStyle.color)
    }

    @discardableResult
    public func backgroundStyle(_ style: BackgroundStyle) -> Self {
        if backgroundStyle == .none && gradientStyle != .none {
            gradientStyle = .none
        }
        self.backgroundStyle = style
        updateAppearance()
        return self
    }

    @discardableResult
    public func gradientStyle(_ style: GradientStyle) -> Self {
        if gradientStyle == .none && backgroundStyle != .none {
            backgroundStyle(.none)
        }
        self.gradientStyle = style
        updateAppearance()
        return self
    }
}
