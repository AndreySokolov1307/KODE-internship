//
//  AccountDetailCellFactory.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import UIKit
import UI

final class AccountDetailCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    // MARK: - Cells

    func makeAccountInfoCell(
        for indexPath: IndexPath,
        with props: AccountInfoView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountInfoView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeInfoTabCell(
        for indexPath: IndexPath,
        with props: InfoTabView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: InfoTabView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeTransactionCell(
        for indexPath: IndexPath,
        with props: TransactionView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TransactionView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeHeaderCell(
        for indexPath: IndexPath,
        with props: HeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
}

