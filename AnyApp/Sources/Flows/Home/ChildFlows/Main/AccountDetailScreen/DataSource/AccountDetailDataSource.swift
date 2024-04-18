//
//  AccountDetailDataSource.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import UIKit
import UI

final class AccountDetailDataSource {

    typealias Section = AccountDetailViewProps.Section
    typealias Item = AccountDetailViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties

    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: AccountDetailCellFactory

    // MARK: - Init

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

    // MARK: - Private methods

    private func setup() {
        tableView.contentInsets(.init(top: 16, left: 0, bottom: 92, right: 0))
        tableView.registerTemplateCell(forView: HeaderView.self)
        tableView.registerTemplateCell(forView: AccountInfoView.self)
        tableView.registerTemplateCell(forView: InfoTabView.self)
        tableView.registerTemplateCell(forView: TransactionView.self)
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
            }
        }
    }
}
