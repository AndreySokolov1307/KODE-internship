import UIKit.UITableView

// swiftlint:disable:next final_class
open class BaseTableView: UITableView {

    // MARK: - Init

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public convenience init(configurator: (BaseTableView) -> Void) {
        self.init(frame: .zero, style: .plain)
        configurator(self)
    }

    // MARK: - Public Methods

    open func setup() {
        tableFooterView = UIView()
        separatorStyle = .none
        backgroundColor = .clear

        // commonly used cells
        registerTemplateCell(forView: BaseSpacer.self)
        registerTemplateCell(forView: BaseSeparator.self)
    }
}
