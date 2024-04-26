//
//  AppThemeView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//

import UI
import UIKit
import AppIndependent

final class AppThemeView: BackgroundPrimary {
   
    let autoThemeView = OptionView()
    let darkThemeView = OptionView()
    let lightThemeView = OptionView()

    var onThemeChanged: ((ThemeRaw) -> Void)?
    
    lazy var options = [autoThemeView, darkThemeView, lightThemeView]
 
    override func setup() {
        super.setup()
        body().embed(in: self)
        configureOptions()
 }

    private func body() -> UIView {
        ScrollView {
            VStack {
                autoThemeView
                darkThemeView
                lightThemeView
                FlexibleSpacer()
            }.layoutMargins(.make(vInsets: 16, hInsets: 16))
        }
    }
    
    private func configureOptions() {
        for (theme, option) in zip(ThemeRaw.allCases.reversed(), options) {
            option.configure(with: theme.title)
            option.onTap { [weak self] in
                self?.selectOption(with: theme)
                self?.onThemeChanged?(theme)
            }
        }
    }
    
    public func selectOption(with theme: ThemeRaw) {
        options.forEach { $0.toNormalState() }
        switch theme {
        case .light:
            lightThemeView.toSelectedState()
        case .dark:
            darkThemeView.toSelectedState()
        case .auto:
            autoThemeView.toSelectedState()
        }
    }
}

extension ThemeRaw {
    var title: String {
        switch self {
        case .auto:
            return Profile.Theme.auto
        case .light:
            return Profile.Theme.light
        case .dark:
            return Profile.Theme.dark
        }
    }
}

