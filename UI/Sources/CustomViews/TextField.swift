// swiftlint:disable:next final_class
open class TextField: BaseTextField, Themeable {

    private(set) var foregroundStyle: ForegroundStyle?
    private(set) var fontStyle: FontStyle?
    private(set) var backgroundStyle: BackgroundStyle?
    private(set) var placeholderForegroundStyle: ForegroundStyle?
    private(set) var placeholderFontStyle: FontStyle?

    convenience init(
        foregroundStyle: ForegroundStyle?,
        fontStyle: FontStyle?,
        backgroundStyle: BackgroundStyle? = nil,
        placeholderForegroundStyle: ForegroundStyle? = nil,
        placeholderFontStyle: FontStyle? = nil
    ) {
        self.init()
        self.foregroundStyle = foregroundStyle
        self.fontStyle = fontStyle
        self.backgroundStyle = backgroundStyle
        self.placeholderForegroundStyle = placeholderForegroundStyle
        self.placeholderFontStyle = placeholderFontStyle
    }

    override public func setup() {
        super.setup()
        subscribeOnThemeChanges()
    }

    @discardableResult
    public func foregroundStyle(_ foregroundStyle: ForegroundStyle) -> Self {
        self.foregroundStyle = foregroundStyle
        updateAppearance()
        return self
    }

    @discardableResult
    public func fontStyle(_ fontStyle: FontStyle) -> Self {
        self.fontStyle = fontStyle
        updateAppearance()
        return self
    }

    @discardableResult
    public func backgroundStyle(_ backgroundStyle: BackgroundStyle) -> Self {
        self.backgroundStyle = backgroundStyle
        updateAppearance()
        return self
    }

    @discardableResult
    public func placeholderForegroundStyle(_ placeholderForegroundStyle: ForegroundStyle) -> Self {
        self.placeholderForegroundStyle = placeholderForegroundStyle
        updateAppearance()
        return self
    }

    @discardableResult
    public func placeholderFontStyle(_ placeholderFontStyle: FontStyle) -> Self {
        self.placeholderFontStyle = placeholderFontStyle
        updateAppearance()
        return self
    }

    override public func updateAppearance() {
        super.updateAppearance()
        if let foregroundStyle {
            textColor(foregroundStyle.color)
            tintColor(foregroundStyle.color)
        }
        if let fontStyle {
            textStyle(fontStyle.textStyle)
        }
        if let backgroundStyle {
            backgroundColor(backgroundStyle.color)
        }
        if let placeholderForegroundStyle {
            placeholderColor(placeholderForegroundStyle.color)
        }
        if let placeholderFontStyle {
            placeholderTextStyle(placeholderFontStyle.textStyle)
        }
    }
}
