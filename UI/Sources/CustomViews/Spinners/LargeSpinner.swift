import UIKit
import Combine

public final class LargeSpinner: Spinner, Themeable {

    // MARK: - Properties

    private var foregroundStyle: ForegroundStyle
    private let color = CurrentValueSubject<UIColor, Never>(.clear)

    // MARK: - Init

    public init(style: ForegroundStyle = .contentPrimary) {
        self.foregroundStyle = style
        super.init(spinnerProps: BaseSpinner.Props(
            size: CGSize(width: 32, height: 32),
            elementsCount: 12,
            elementSize: CGSize(width: 2, height: 9),
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
        self.foregroundStyle = style
        updateAppearance()
        return self
    }
}
