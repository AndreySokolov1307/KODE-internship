import UIKit

// swiftlint:disable:next final_class
open class BaseTableCellFactory {

    // MARK: - Public Properties

    public let tableView: BaseTableView

    // MARK: - Lifecycle

    public init(tableView: BaseTableView) {
        self.tableView = tableView

        tableView.registerTemplateCell(forView: BaseTableSpacer.self)
    }
}
