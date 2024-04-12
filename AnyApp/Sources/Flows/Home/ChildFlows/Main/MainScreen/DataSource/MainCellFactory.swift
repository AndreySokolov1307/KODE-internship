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

    func makeShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateShimmerView.self,
            for: indexPath
        )
    }

    // MARK: - Cells

    func makeTemplateCell(
        for indexPath: IndexPath,
        with props: TemplateView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
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
    
    func makeCurrentAccountCell(
        for indexPath: IndexPath,
        with props: CurrentAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: CurrentAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeAdditionalAccountCell(
        for indexPath: IndexPath,
        with props: AdditionalAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: AdditionalAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateHeaderCell(
        for indexPath: IndexPath,
        with props: TemplateHeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateHeaderView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
}

