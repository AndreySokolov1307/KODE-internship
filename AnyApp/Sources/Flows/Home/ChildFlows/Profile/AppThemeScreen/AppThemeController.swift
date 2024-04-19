//
//  AppThemeController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//
import UI
import UIKit

final class AppThemeController: TemplateViewController<AppThemeView> {

    typealias ViewModel = AppThemeViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.currentTheme)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = Profile.Theme.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupBindings() {
        rootView.onThemeChanged = { [weak self] theme in
            self?.viewModel.handle(.themeChoosen(theme))
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .theme(let theme):
                AppearanceManager.shared.setTheme(theme)
            case .currentTheme(let theme):
                self?.rootView.configureOptions(with: theme)
            }
        }
    }
}

