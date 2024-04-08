import UIKit

// swiftlint:disable:next final_class
open class BaseNavigationBar: UINavigationBar {

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Methods to Implement

    open func setup() { }
}
