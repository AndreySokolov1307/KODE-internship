//
//  AppThemeViewController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//

import Services
import UI

final class AppThemeViewModel {
    
    enum Input {
        case themeChoosen(ThemeRaw)
        case currentTheme
    }
    
    enum Output {
        case theme(ThemeRaw)
        case currentTheme(ThemeRaw)
    }
    
    var currentTheme = AppearanceManager.shared.themeRaw
    var onOutput: ((Output) -> Void)?
    
    func handle(_ input: Input) {
        switch input {
        case .themeChoosen(let theme):
            self.onOutput?(.theme(theme))
        case .currentTheme:
            self.onOutput?(.currentTheme(currentTheme))
        }
    }
}
