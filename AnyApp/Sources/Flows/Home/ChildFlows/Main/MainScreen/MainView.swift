//
//  MainView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UI
import UIKit
import AppIndependent

final class MainView: BackgroundPrimary {

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
    private let button = ButtonPrimary(title: "!Новый продукт")
    private lazy var dataSource = MainDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupButton()
    }

    private func body() -> UIView {
        tableView
    }

    private func setupButton() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(24)
        }
        button.onTap { [weak self] in
            self?.onNewProduct?()
        }
    }

//    ScrollView {
//        VStack {
//            HStack {
//                profileAvatarHeaderView
//                Spacer(.px20)
//                ForEach(collection: settings, spacing: 30) {
//                    Label(text: $0.rawValue)
//                }
//            }
//        }
//    }
}

extension MainView: ConfigurableView {
    typealias Model = MainViewProps

    func configure(with model: MainViewProps) {
        dataSource.apply(sections: model.sections)
    }
}
