import UIKit.UITableView

// swiftlint:disable:next final_class
open class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    // MARK: - Init

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Public Methods

    open func setup() { }

    open func updateAppearance() { }
}
