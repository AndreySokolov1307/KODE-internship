import UIKit
import Combine

// swiftlint:disable:next final_class
open class BaseBrandButton: BaseLoadingButton, Themeable {

    public enum FontStyle {
        case button
    }

    public enum Size {
        case medium
        case large
    }

    public let size: Size

    @Published public private(set) var foregroundStyle: ForegroundStyle?
    public private(set) var fontStyle: FontStyle = .button
    public var contentInteractionAlpha: CGFloat { 0.4 }

    public var cancellables = Set<AnyCancellable>()

    public init(title: String? = nil, image: UIImage? = nil, size: Size = .large) {
        self.size = size
        super.init(title: title, image: image)

        if image != nil {
            setupContentInsets()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override public func setup() {
        super.setup()
        height(size.height, priority: .required)
        subscribeOnThemeChanges()
        cornerRadius(size.radius)
    }

    @discardableResult
    public func leftIcon(icon: UIImage) -> Self {
        accessory(.image(icon, .beforeTitle(padding: 6)))
    }

    @discardableResult
    public func rightIcon(icon: UIImage) -> Self {
        accessory(.image(icon, .afterTitle(padding: 6)))
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
        updateAppearance()
        return self
    }

    override public func makeLoaderView() -> UIView {
        let loaderView = MediumSpinner(style: .contentPrimary)

        $foregroundStyle
            .compactMap { $0 }
            .sink { [weak loaderView] style in
                loaderView?.foregroundStyle(style)
            }
            .store(in: &cancellables)

        return loaderView
    }

    override public func updateAppearance() {
        super.updateAppearance()
        titleLabel?.textStyle(fontStyle.textStyle)
    }

    override open func setupDefaultAppearance() {
        super.setupDefaultAppearance()

        guard let foregroundStyle else { return }

        titleColor(foregroundStyle.color, for: .normal)
        titleColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha), for: .highlighted)
        titleColor(foregroundStyle.color, for: .selected)
        titleColor(foregroundStyle.color, for: .focused)
        titleColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha), for: .disabled)

        tintColor(foregroundStyle.color)
        accessoryView?.tintColor(foregroundStyle.color)
    }

    override open func setupActiveAppearance() {
        super.setupActiveAppearance()

        guard let foregroundStyle else { return }
        tintColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha))
        accessoryView?.tintColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha))
    }

    override open func setupLoadingAppearance() {
        super.setupLoadingAppearance()
        accessoryView?.tintColor(.clear)

        guard let foregroundStyle else { return }
        tintColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha))
        titleColor(accessoryView == nil ? .clear : foregroundStyle.color.withAlphaComponent(contentInteractionAlpha), for: .disabled)
    }

    override open func setupDisabledAppearance() {
        super.setupDisabledAppearance()

        guard let foregroundStyle else { return }
        accessoryView?.tintColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha))
        tintColor(foregroundStyle.color.withAlphaComponent(contentInteractionAlpha))
    }

    private func setupContentInsets() {
        contentEdgeInsets = .make(hInsets: 10)
    }
}

// swiftlint:disable:next final_class
public class BaseStretchingBrandButton: BaseBrandButton {

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: size.height)
    }
}

extension BaseBrandButton.FontStyle {

    var textStyle: TextStyle? {
        switch self {
        case .button:
            return Typography.button
        }
    }
}

public extension BaseBrandButton.Size {

    var height: CGFloat {
        switch self {
        case .medium:
            return 40
        case .large:
            return 52
        }
    }

    var radius: CGFloat {
        switch self {
        case .medium:
            return 12
        case .large:
            return 26
        }
    }
}
