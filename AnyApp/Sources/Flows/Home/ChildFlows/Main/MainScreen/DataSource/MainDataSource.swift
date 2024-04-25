//
//  MainDataSource.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI

final class MainDataSource {

    typealias Section = MainViewProps.Section
    typealias Item = MainViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties

    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: MainCellFactory

    // MARK: - Init

    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = MainCellFactory(tableView: tableView)
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
        tableView.registerTemplateCell(forView: HeaderShimmerView.self)
        tableView.registerTemplateCell(forView: AccountShimmerView.self)
        tableView.registerTemplateCell(forView: HeaderView.self)
        tableView.registerTemplateCell(forView: DepostiView.self)
        tableView.registerTemplateCell(forView: AccountView.self)
        tableView.registerTemplateCell(forView: AccountCardView.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .headerShimmer:
                return cellFactory.makeHeaderShimmer(for: indexPath)
            case .accountShimmer:
                return cellFactory.makeAccountShimmer(for: indexPath)
            case .header(let props):
                return cellFactory.makeHeaderCell(for: indexPath, with: props)
            case .account(let props):
                return cellFactory.makeAccountCell(for: indexPath, with: props)
            case .card(let props):
                return cellFactory.makeAccountCardCell(for: indexPath, with: props)
            case .deposit(let props):
                return cellFactory.makeDepositCell(for: indexPath, with: props)
            }
        }
    }
}
