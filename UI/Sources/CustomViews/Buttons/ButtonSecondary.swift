import UIKit

public final class ButtonSecondary: BaseStretchingBrandButton {

    override public var contentInteractionAlpha: CGFloat { 0.4 }

    override public func setup() {
        super.setup()
        foregroundStyle(.button)
    }

    override public func setupDefaultAppearance() {
        super.setupDefaultAppearance()
        animateBackgroundColor(Palette.Button.buttonSecondary)
    }
}
