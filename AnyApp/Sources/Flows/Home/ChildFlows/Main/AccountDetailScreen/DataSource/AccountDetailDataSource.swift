import UIKit
import UI

final class AccountDetailDataSource {

    typealias Section = AccountDetailViewProps.Section
    typealias Item = AccountDetailViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private Properties

    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: AccountDetailCellFactory

    // MARK: - AccountDetailDataSource

    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = AccountDetailCellFactory(tableView: tableView)
        setup()
        configure()
    }

    // MARK: - Public Methods

    public func apply(sections: [Section]) {
        var snap = NSDiffableDataSourceSnapshot<Section, Item>()
        snap.appendSections(sections)
        sections.forEach {
            snap.appendItems($0.items, toSection: $0)
        }
        dataSource?.apply(snap, animatingDifferences: false)
    }
    
    // MARK: - Private Methods

    private func setup() {
        tableView.contentInsets(.init(top: 16, left: 0, bottom: 92, right: 0))
        tableView.registerTemplateCell(forView: HeaderView.self)
        tableView.registerTemplateCell(forView: AccountInfoView.self)
        tableView.registerTemplateCell(forView: InfoTabView.self)
        tableView.registerTemplateCell(forView: TransactionView.self)
        tableView.registerTemplateCell(forView: InfoView.self)
        tableView.registerTemplateCell(forView: PaymentView.self)
        tableView.registerTemplateCell(forView: AccountShimmerView.self)
        tableView.registerTemplateCell(forView: AccountInfoShimmerView.self)
        tableView.registerTemplateCell(forView: InfoTabShimmerView.self)
        tableView.registerTemplateCell(forView: HeaderShimmerView.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .header(let props):
                return cellFactory.makeHeaderCell(for: indexPath, with: props)
            case .accountInfo(let props):
                return cellFactory.makeAccountInfoCell(for: indexPath, with: props)
            case .tab(let props):
                return cellFactory.makeInfoTabCell(for: indexPath, with: props)
            case .transaction(let props):
                return cellFactory.makeTransactionCell(for: indexPath, with: props)
            case .action(let props):
                return cellFactory.makeActionCell(for: indexPath, with: props)
            case .payment(let props):
                return cellFactory.makePaymentCell(for: indexPath, with: props)
            case .transactionShimmer:
                return cellFactory.makeTransactionShimmer(for: indexPath)
            case .accountInfoShimmer:
                return cellFactory.makeAccountInfoShimmer(for: indexPath)
            case .infoTabShimmer:
                return cellFactory.makeInfoTabShimmer(for: indexPath)
            case .headerShimmer:
                return cellFactory.makeHeaderShimmer(for: indexPath)
            }
        }
    }
}
