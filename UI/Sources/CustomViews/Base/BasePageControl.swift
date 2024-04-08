import UIKit

// swiftlint:disable:next final_class
open class BasePageControl: UIPageControl {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateAppearance()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    open func setup() { }

    open func updateAppearance() { }
}
