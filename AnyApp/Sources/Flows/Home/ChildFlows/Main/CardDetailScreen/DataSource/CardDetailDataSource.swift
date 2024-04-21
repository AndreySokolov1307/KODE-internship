//
//  CardDetailDataSource.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//

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

    // MARK: - Init

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
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
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
