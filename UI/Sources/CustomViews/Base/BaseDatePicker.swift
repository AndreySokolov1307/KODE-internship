import UIKit

@available(iOS 13.4, *)
open class BaseDatePicker: UIDatePicker {
// swiftlint:disable:previous final_class

    // MARK: - Lifecycle

    public init(mode: UIDatePicker.Mode, style: UIDatePickerStyle) {
        super.init(frame: .zero)

        self.datePickerMode = mode
        self.preferredDatePickerStyle = style

        setup()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    open func setup() {
        updateAppearance()
    }

    open func updateAppearance() { }
}
