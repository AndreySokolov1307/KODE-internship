//
//  CardDetailView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//


import UI
import UIKit
import AppIndependent

final class CardDetailView: BackgroundPrimary {

    private let tableView = BaseTableView()
    private lazy var dataSource = CardDetailDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        tableView
    }
}

extension CardDetailView: ConfigurableView {
    typealias Model = CardDetailViewProps

    func configure(with model: CardDetailViewProps) {
        dataSource.apply(sections: model.sections)
    }
}
