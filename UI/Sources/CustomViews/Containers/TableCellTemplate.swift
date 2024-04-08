import UIKit

// swiftlint:disable:next final_class
open class TableCellTemplate<View: UIView>: UITableViewCell {

    public var view: View!

    // MARK: - Init

    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
        setup()
    }

    // MARK: - Public Methods

    open func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    open func layout() {
        makeView()
        contentView.addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = contentView.bounds
    }

    open func makeView() {
        view = View()
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        (view as? PreparableForReuse)?.prepareForReuse()
    }
}
