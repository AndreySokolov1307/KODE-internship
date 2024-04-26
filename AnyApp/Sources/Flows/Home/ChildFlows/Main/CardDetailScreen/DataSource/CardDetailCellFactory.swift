//
//  CardDetailCellFactory.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//


import UIKit
import UI

final class CardDetailCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }
    
    // MARK: - Common
    
    func makeCardInfoShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: CardInfoShimmerView.self,
            for: indexPath
        )
    }
    
    func makeTransactionShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountShimmerView.self,
            for: indexPath
        )
    }
    
    func makeInfoTabShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: InfoTabShimmerView.self,
            for: indexPath
        )
    }
    
    func makeHeaderShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderShimmerView.self,
            for: indexPath
        )
    }

    // MARK: - Cells

    func makeCardInfoCell(
        for indexPath: IndexPath,
        with props: CardInfoView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: CardInfoView.self,
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
    
    func makeActionCell(
        for indexPath: IndexPath,
        with props: InfoView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: InfoView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makePaymentCell(
        for indexPath: IndexPath,
        with props: PaymentView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: PaymentView.self,
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


