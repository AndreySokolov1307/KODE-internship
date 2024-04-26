//
//  MainController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UI
import UIKit

final class MainController: TemplateViewController<MainView> {

    typealias ViewModel = MainViewModel
    
    enum Event {
        case accountDetail(AccountDetailConfigModel)
        case cardDetail(CardDetailConfigModel)
    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadData)
    }

    private func configureNavigationItem() {
        navigationItem.title = Main.main
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            case .accountDetail(let configModel):
                self?.onEvent?(.accountDetail(configModel))
            case .cardDetail(let configModel):
                self?.onEvent?(.cardDetail(configModel))
            }
        }

        rootView.onNewProduct = { 
            SnackCenter.shared.showSnack(withProps: .init(message: "!New Product"))
        }
    }
}

