import UIKit

public final class ButtonPrimary: BaseStretchingBrandButton {

    override public var contentInteractionAlpha: CGFloat { 0.6 }

    override public func setup() {
        super.setup()
        foregroundStyle(.button)
    }

    override public func setupDefaultAppearance() {
        super.setupDefaultAppearance()
        animateBackgroundColor(Palette.Button.buttonPrimary)
    }
}
