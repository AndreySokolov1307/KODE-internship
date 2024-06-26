import UIKit
import UI

final class CardDetailDataSource {

    typealias Section = CardDetailViewProps.Section
    typealias Item = CardDetailViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties

    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: CardDetailCellFactory

    // MARK: - CardDetailDataSource

    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = CardDetailCellFactory(tableView: tableView)
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

    // MARK: - Private methods

    private func setup() {
        tableView.contentInsets(.init(top: 16, left: 0, bottom: 92, right: 0))
        tableView.registerTemplateCell(forView: HeaderView.self)
        tableView.registerTemplateCell(forView: CardInfoView.self)
        tableView.registerTemplateCell(forView: InfoTabView.self)
        tableView.registerTemplateCell(forView: TransactionView.self)
        tableView.registerTemplateCell(forView: InfoView.self)
        tableView.registerTemplateCell(forView: PaymentView.self)
        tableView.registerTemplateCell(forView: CardInfoShimmerView.self)
        tableView.registerTemplateCell(forView: InfoTabShimmerView.self)
        tableView.registerTemplateCell(forView: AccountShimmerView.self)
        tableView.registerTemplateCell(forView: HeaderShimmerView.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .headerShimmer:
                return cellFactory.makeHeaderShimmer(for: indexPath)
            case .infoTabShimmer:
                return cellFactory.makeInfoTabShimmer(for: indexPath)
            case .transactionShimmer:
                return cellFactory.makeTransactionShimmer(for: indexPath)
            case .cardShimmer:
                return cellFactory.makeCardInfoShimmer(for: indexPath)
            case .header(let props):
                return cellFactory.makeHeaderCell(for: indexPath, with: props)
            case .card(let props):
                return cellFactory.makeCardInfoCell(for: indexPath, with: props)
            case .tab(let props):
                return cellFactory.makeInfoTabCell(for: indexPath, with: props)
            case .transaction(let props):
                return cellFactory.makeTransactionCell(for: indexPath, with: props)
            case .action(let props):
                return cellFactory.makeActionCell(for: indexPath, with: props)
            case .payment(let props):
                return cellFactory.makePaymentCell(for: indexPath, with: props)
            }
        }
    }
}
