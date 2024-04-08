import UIKit.UITableView

// swiftlint:disable:next final_class
open class BaseTableViewCell: UITableViewCell {

    // MARK: - Init

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        updateAppearance()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        updateAppearance()
    }

    // MARK: - Public Methods

    open func setup() {
        selectionStyle = .none
    }

    open func updateAppearance() { }
}
