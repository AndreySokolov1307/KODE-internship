//
//  AccountDetailView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import UI
import UIKit
import AppIndependent

final class AccountDetailView: BackgroundPrimary {

    private let tableView = BaseTableView()
    private lazy var dataSource = AccountDetailDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            tableView
        }.layoutMargins(.make(hInsets: 16))
    }
}

extension AccountDetailView: ConfigurableView {
    typealias Model = AccountDetailViewProps

    func configure(with model: AccountDetailViewProps) {
        dataSource.apply(sections: model.sections)
    }
    
    func update(with section: AccountDetailViewProps.Section) {
        dataSource.updateLastSection(with: section)
    }
}
