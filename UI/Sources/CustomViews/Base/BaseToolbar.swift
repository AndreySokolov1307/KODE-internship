import UIKit

// swiftlint:disable:next final_class
open class BaseToolbar: UIToolbar {

    // MARK: - Lifecycle

    public init() {
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.width, height: 44))
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
