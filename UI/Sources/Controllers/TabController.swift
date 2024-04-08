import UIKit

public final class TabController: UITabBarController, Themeable {

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.backButtonTitle = ""
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    public func setup() {
        subscribeOnThemeChanges()
        updateAppearance()
    }

    public func updateAppearance() {
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = Palette.Text.secondary
        itemAppearance.normal.titleTextAttributes = [
            .font: Typography.caption2?.font as Any,
            .foregroundColor: Palette.Text.secondary
        ]

        itemAppearance.selected.iconColor = Palette.Content.accentSecondary
        itemAppearance.selected.titleTextAttributes = [
            .font: Typography.caption2?.font as Any,
            .foregroundColor: Palette.Content.accentSecondary
        ]

        let standardAppearance = UITabBarAppearance()
        standardAppearance.stackedLayoutAppearance = itemAppearance
        standardAppearance.backgroundColor = Palette.Surface.backgroundPrimary
        standardAppearance.backgroundEffect = .none
        standardAppearance.shadowColor = .clear
        tabBar.standardAppearance = standardAppearance
        tabBar.scrollEdgeAppearance = standardAppearance
    }
}
