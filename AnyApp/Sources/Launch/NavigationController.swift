import UIKit
import UI

final class NavigationController: BaseNavigationController, Themeable {
    func updateAppearance() {
        navigationBar.tintColor(Palette.Button.buttonSecondary)
    }
    
    override func setup() {
        navigationBar.backIndicatorImage = Asset.Images.backArrow.image
        navigationBar.backIndicatorTransitionMaskImage = Asset.Images.backArrow.image
        subscribeOnThemeChanges()
        updateAppearance()
    }
}
