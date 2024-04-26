//
//  AppThemeController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//
import UI
import UIKit
import Combine

final class AppThemeController: TemplateViewController<AppThemeView> {

    typealias ViewModel = AppThemeViewModel

    private var viewModel: ViewModel!
    
    private var cancellable = Set<AnyCancellable>()

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = Profile.Theme.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupBindings() {
        rootView.onThemeChanged = { [weak self] theme in
            self?.viewModel.handle(.themeChoosen(theme))
        }
        
        viewModel.currentTheme
            .removeDuplicates()
            .sink { theme in
                AppearanceManager.shared.setTheme(theme)
            }
            .store(in: &cancellable)
        
        AppearanceManager.shared.$themeRaw
            .removeDuplicates()
            .sink { [weak self] theme in
                self?.rootView.selectOption(with: theme)
            }
            .store(in: &cancellable)
    }
}

