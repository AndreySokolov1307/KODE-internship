import UIKit

public final class NavigationBar: BaseNavigationBar, Themeable {

    public enum Style {
        case clear
        case background
        case layer1
    }

    private var style: Style = .background

    override public func setup() {
        super.setup()
        subscribeOnThemeChanges()
        updateAppearance()
    }

    public func updateAppearance() {
//        let standardAppearance = UINavigationBarAppearance()
//
//        tintColor(Palette.Content.accent)
//
//        let arrowImage = Assets.Icons.backButton.image
//            .withAlignmentRectInsets(.init(top: 0, left: -8, bottom: 0, right: 0))
//
//        standardAppearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)
//
//        standardAppearance.titleTextAttributes = [
//            .foregroundColor: Palette.Content.primary.uiColor,
//            .font: Typography.subhead1?.font ?? .preferredFont(forTextStyle: .headline)
//        ]
//
//        standardAppearance.buttonAppearance.normal.titleTextAttributes = [
//            .font: Typography.subhead1?.font ?? .preferredFont(forTextStyle: .headline)
//        ]
//        standardAppearance.doneButtonAppearance.normal.titleTextAttributes = [
//            .font: Typography.body1?.font ?? .preferredFont(forTextStyle: .body)
//        ]
//
//        standardAppearance.shadowColor = Palette.Border.regular.uiColor
//
//        let scrollEdgeAppearance = standardAppearance.copy()
//        scrollEdgeAppearance.shadowColor = .clear
//
//        switch style {
//        case .background:
//            scrollEdgeAppearance.backgroundColor = Palette.Surface.background.uiColor
//            standardAppearance.backgroundColor = Palette.Surface.layer2.uiColor
//        case .layer1:
//            scrollEdgeAppearance.backgroundColor = Palette.Surface.layer1.uiColor
//            standardAppearance.backgroundColor = Palette.Surface.layer3.uiColor
//        case .clear:
//            standardAppearance.configureWithTransparentBackground()
//            scrollEdgeAppearance.configureWithTransparentBackground()
//        }
//
//        self.standardAppearance = standardAppearance
//        self.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

public extension NavigationBar {
    @discardableResult
    func style(_ style: Style) -> Self {
        self.style = style
        updateAppearance()
        return self
    }
}
