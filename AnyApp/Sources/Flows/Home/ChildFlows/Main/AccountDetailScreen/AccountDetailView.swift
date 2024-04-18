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

  //  var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
    private lazy var dataSource = AccountDetailDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        tableView
    }
}

extension AccountDetailView: ConfigurableView {
    typealias Model = AccountDetailViewProps

    func configure(with model: AccountDetailViewProps) {
        dataSource.apply(sections: model.sections)
    }
}
