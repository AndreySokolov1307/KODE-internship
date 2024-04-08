import UIKit.UISwitch

// swiftlint:disable:next final_class
open class BaseSwitch: UISwitch {

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Methods to Implement

    open func setup() {
        updateAppearance()
    }

    open func updateAppearance() { }
}
