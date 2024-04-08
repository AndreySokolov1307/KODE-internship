import UIKit
import Combine
import AppIndependent

public final class AppearanceManager {

    // MARK: - Constants

    private enum Constant {
        static let themeKey = "theme"
    }

    public enum Event {
        static let themeChanged = NSNotification.Name(rawValue: "AppearanceManager.themeChanged")
    }

    // MARK: - Public Properties

    public static let shared = AppearanceManager()

    @Published public private(set) var themeRaw: ThemeRaw
    @Published public private(set) var theme: Theme

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()

    private static var themeAuto: Theme {
        switch UIApplication.shared.userInterfaceStyle {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return .light
        }
    }

    // MARK: - AppearanceManager

    private init() {
        let themeRaw: ThemeRaw
        if let savedThemeKey = UserDefaults.standard.string(forKey: Constant.themeKey),
            let savedTheme = ThemeRaw(rawValue: savedThemeKey) {
            themeRaw = savedTheme
        } else {
            themeRaw = .auto
        }

        self.themeRaw = themeRaw
        theme = AppearanceManager.map(themeRaw: themeRaw)
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func setTheme(_ theme: ThemeRaw) {
        themeRaw = theme
        UserDefaults.standard.set(theme.rawValue, forKey: Constant.themeKey)
    }

    public func updateThemeIfNeeded() {
        if themeRaw == .auto {
            themeRaw = .auto
        }
    }

    // MARK: - Private Methods

    private static func map(themeRaw: ThemeRaw) -> Theme {
        switch themeRaw {
        case .light:
            return .light
        case .dark:
            return .dark
        case .auto:
            return themeAuto
        }
    }

    private func setupBindings() {
        $themeRaw
            .map { AppearanceManager.map(themeRaw: $0) }
            .assign(to: &$theme)

        $theme
            .dropFirst()
            .sink { theme in
                NotificationCenter.default.post(name: Event.themeChanged, object: nil)
                Logger().info("Setup app theme: \(String(describing: theme))")
            }.store(in: &cancellables)
    }
}
