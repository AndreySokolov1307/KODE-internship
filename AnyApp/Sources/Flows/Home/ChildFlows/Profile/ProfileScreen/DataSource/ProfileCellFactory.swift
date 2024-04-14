//
//  ProfileCellFactory.swift
//  AnyApp
//
//  Created by Андрей Соколов on 13.04.2024.
//

import UI
import UIKit

final class ProfileCellFactory {
    
    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }
    
    // MARK: - Common

    func makeProfileShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ProfileDetailShimmerView.self,
            for: indexPath
        )
    }
    
    func makeInfoShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: InfoShimmerView.self,
            for: indexPath
        )
    }
    
    // MARK: - Cells
    
    func makeProfileDetailCell(
        for indexPath: IndexPath,
        with props: ProfileDetailView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ProfileDetailView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeInfoCell(
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
}
