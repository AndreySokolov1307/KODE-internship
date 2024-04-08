import UIKit
import Combine

public final class MediumSpinner: Spinner, Themeable {

    // MARK: - Properties

    public let color = CurrentValueSubject<UIColor, Never>(.clear)
    private var foregroundStyle: ForegroundStyle

    // MARK: - Init

    public init(style: ForegroundStyle = .contentPrimary) {
        foregroundStyle = style
        super.init(spinnerProps: BaseSpinner.Props(
            size: CGSize(width: 24, height: 24),
            elementsCount: 12,
            elementSize: CGSize(width: 2, height: 7),
            elementsAnimationDuration: 1,
            elementColor: color.map(\.cgColor).eraseToAnyPublisher()
        ))
    }

    // MARK: - Methods

    override public func setup() {
        super.setup()
        subscribeOnThemeChanges()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func updateAppearance() {
        super.updateAppearance()
        color.send(foregroundStyle.color)
    }

    @discardableResult
    public func foregroundStyle(_ style: ForegroundStyle) -> Self {
        foregroundStyle = style
        updateAppearance()
        return self
    }
}
