//
//  AccountDetailController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import UI
import UIKit

final class AccountDetailViewController: TemplateViewController<AccountDetailView> {

    typealias ViewModel = AccountDetailViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.accountData)
    }

    private func configureNavigationItem() {
        navigationItem.title = "VAMOOOOS"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            }
        }

//        rootView.onNewProduct = { [weak self] in
//            SnackCenter.shared.showSnack(withProps: .init(message: "!New Product"))
//        }
    }
}
