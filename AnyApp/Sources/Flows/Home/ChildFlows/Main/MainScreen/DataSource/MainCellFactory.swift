//
//  MainCellFactory.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UIKit
import UI

final class MainCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    // MARK: - Common

    func makeAccountShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountShimmerView.self,
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
    
    func makeDepositCell(
        for indexPath: IndexPath,
        with props: DepostiView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: DepostiView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeAccountCell(
        for indexPath: IndexPath,
        with props: AccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeAccountCardCell(
        for indexPath: IndexPath,
        with props: AccountCardView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AccountCardView.self,
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
