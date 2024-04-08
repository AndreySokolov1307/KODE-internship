public protocol Themeable: AnyObject {
    func updateAppearance()
}

public extension Themeable {

    func subscribeOnThemeChanges() {
        NotificationCenter.default.addObserver(
            forName: AppearanceManager.Event.themeChanged,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateAppearance()
            }
        }
    }
}
