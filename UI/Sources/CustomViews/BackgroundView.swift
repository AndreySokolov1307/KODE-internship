// swiftlint:disable:next final_class
open class BackgroundView: BaseBackgroundView, Themeable {

    public private(set) var backgroundStyle: BackgroundStyle?
    public private(set) var borderStyle: BorderStyle?

    override open func setup() {
        super.setup()
        subscribeOnThemeChanges()
    }

    @discardableResult
    public func backgroundStyle(_ style: BackgroundStyle) -> Self {
        self.backgroundStyle = style
        updateAppearance()
        return self
    }

    @discardableResult
    public func borderStyle(_ borderStyle: BorderStyle, width: CGFloat = 1) -> Self {
        self.borderStyle = borderStyle
        self.borderWidth = width

        updateAppearance()
        return self
    }

    override open func updateAppearance() {
        super.updateAppearance()
        _ = backgroundStyle.flatMap { backgroundColor($0.color) }

        if let borderStyle {
            borderColor(borderStyle.color)
        }
    }
}
