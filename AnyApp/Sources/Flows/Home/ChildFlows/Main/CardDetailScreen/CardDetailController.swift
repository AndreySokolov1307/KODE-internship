//
//  CardDetailController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//

import UI
import UIKit

final class CardDetailController: TemplateViewController<CardDetailView> {
    
    typealias ViewModel = CardDetailViewModel
    
    private var viewModel: ViewModel!
    
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.transactions)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Card"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            guard let self else { return }
            switch output {
            case .content(let props):
                self.rootView.configured(with: props)
            }
        }
    }
}
