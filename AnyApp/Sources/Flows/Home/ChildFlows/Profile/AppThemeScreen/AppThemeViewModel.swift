import Services
import Combine
import UI

final class AppThemeViewModel {
    
    enum Input {
        case themeChoosen(ThemeRaw)
    }
    
    // MARK: - Public Properties
    
    var currentTheme = PassthroughSubject<ThemeRaw, Never>()
    
    // MARK: - Public Methods
    
    func handle(_ input: Input) {
        switch input {
        case .themeChoosen(let theme):
            self.currentTheme.send(theme)
        }
    }
}
