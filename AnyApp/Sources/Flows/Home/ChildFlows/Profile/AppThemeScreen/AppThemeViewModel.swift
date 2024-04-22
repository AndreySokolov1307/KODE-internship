//
//  AppThemeViewController.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//

import Services
import Combine
import UI

final class AppThemeViewModel {
    
    enum Input {
        case themeChoosen(ThemeRaw)
    }
    
    var currentTheme = CurrentValueSubject<ThemeRaw, Never>(AppearanceManager.shared.themeRaw)
    
    func handle(_ input: Input) {
        switch input {
        case .themeChoosen(let theme):
            self.currentTheme.send(theme)
        }
    }
}
