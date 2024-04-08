import UIKit

// swiftlint:disable:next final_class
open class ImageView: BaseImageView, Themeable {

    // MARK: - Private Properties

    public private(set) var foregroundStyle: ForegroundStyle?
    public private(set) var borderStyle: BorderStyle?

    // MARK: - Init

    public init(image: UIImage? = nil, foregroundStyle: ForegroundStyle? = nil) {
        self.foregroundStyle = foregroundStyle
        super.init(image: image)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setup() {
        super.setup()
        subscribeOnThemeChanges()
        updateAppearance()
    }

    // MARK: - Public Methods

    @discardableResult
    public func foregroundStyle(_ foregroundStyle: ForegroundStyle) -> Self {
        self.foregroundStyle = foregroundStyle
        updateAppearance()
        return self
    }

    @discardableResult
    public func borderStyle(_ borderStyle: BorderStyle, width: CGFloat) -> Self {
        self.borderStyle = borderStyle
        borderWidth(width)
        updateAppearance()
        return self
    }

    @discardableResult
    public func removeBorder() -> Self {
        borderStyle = nil
        borderColor(.clear)
        borderWidth(.zero)
        return self
    }

    override public func updateAppearance() {
        super.updateAppearance()
        if let foregroundStyle {
            tintColor(foregroundStyle.color)
        }
        if let borderStyle {
            borderColor(borderStyle.color)
        }
    }
}
