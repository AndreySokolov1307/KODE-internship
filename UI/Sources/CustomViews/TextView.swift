import UIKit

// https://app.clickup.com/t/8693gkaq3
// swiftlint:disable:next final_class
open class TextView: BaseTextView, Themeable {

    public private(set) var foregroundStyle: ForegroundStyle?
    public private(set) var fontStyle: FontStyle?
    public private(set) var linkStyle: ForegroundStyle = .textPrimary //.accent

    public init(foregroundStyle: ForegroundStyle? = nil, fontStyle: FontStyle? = nil) {
        self.foregroundStyle = foregroundStyle
        self.fontStyle = fontStyle
        super.init(frame: .zero, textContainer: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func setup() {
        super.setup()
        subscribeOnThemeChanges()
        updateAppearance()
    }

    @discardableResult
    public func foregroundStyle(_ style: ForegroundStyle) -> Self {
        self.foregroundStyle = style
        updateAppearance()
        return self
    }

    @discardableResult
    public func fontStyle(_ style: FontStyle) -> Self {
        self.fontStyle = style
        textStyle(style.textStyle)
        return self
    }

    @discardableResult
    public func linkStyle(_ style: ForegroundStyle) -> Self {
        self.linkStyle = style
        updateAppearance()
        return self
    }

    @discardableResult
    public func htmlText(_ text: String?) -> Self {
        guard let text,
              let attributedString = NSAttributedString(htmlString: text)?
            .color(foregroundStyle?.color)
        else { return self }

        // Applying font from fontStyle keeping traits (bold, italic, etc.) from HTML string
        if let font = fontStyle?.textStyle?.font {
            var traitsRanges = [(UIFontDescriptor.SymbolicTraits?, NSRange)]()
            attributedString.enumerateAttribute(.font, in: attributedString.range) { value, range, _ in
                traitsRanges.append(((value as? UIFont)?.fontDescriptor.symbolicTraits, range))
            }

            traitsRanges.forEach { (traits, range) in
                guard let traits,
                      let fontDescriptor = font.fontDescriptor.withSymbolicTraits(traits)
                else { return }

                attributedString.addAttribute(
                    .font,
                    value: UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize),
                    range: range
                )
            }
        }

        attributedText(attributedString)
        return self
    }

    override public func updateAppearance() {
        super.updateAppearance()
        if let foregroundStyle {
            textColor(foregroundStyle.color)
            tintColor(foregroundStyle.color)
        }
        linkTextAttributes([
            .foregroundColor: linkStyle.color,
            .underlineStyle: 0
        ])
    }
}
