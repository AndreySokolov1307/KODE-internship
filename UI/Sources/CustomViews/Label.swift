import UIKit

// swiftlint:disable:next final_class
open class Label: BaseLabel, Themeable {

    public private(set) var foregroundStyle: ForegroundStyle?
    public private(set) var fontStyle: FontStyle?

    public init(text: String? = nil, foregroundStyle: ForegroundStyle? = nil, fontStyle: FontStyle? = nil) {
        self.foregroundStyle = foregroundStyle
        self.fontStyle = fontStyle
        super.init(frame: .zero)
        self.text = text
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    override public func updateAppearance() {
        super.updateAppearance()
        if let foregroundStyle {
            textColor(foregroundStyle.color)
            tintColor(foregroundStyle.color)
        }
        if let fontStyle {
            textStyle(fontStyle.textStyle)
        }
    }
}
