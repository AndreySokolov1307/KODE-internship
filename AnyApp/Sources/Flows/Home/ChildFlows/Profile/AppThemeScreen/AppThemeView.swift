import UI
import UIKit
import AppIndependent

final class AppThemeView: BackgroundPrimary {
    
    // MARK: - Public Properties
   
    let autoThemeView = OptionView()
    let darkThemeView = OptionView()
    let lightThemeView = OptionView()

    var onThemeChanged: ((ThemeRaw) -> Void)?
    
    lazy var options = [autoThemeView, darkThemeView, lightThemeView]
 
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        configureOptions()
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

    // MARK: - Private Methods
    
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

