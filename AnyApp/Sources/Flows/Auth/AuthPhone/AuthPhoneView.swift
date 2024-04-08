import UI
import UIKit
import AppIndependent

final class AuthPhoneView: BackgroundPrimary {

    var onAuth: VoidHandler?

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            FlexibleGroupedSpacer()

            TextField(placeholder: "!Phone")
            Spacer(.px16)
            ButtonPrimary(title: "!Auth")
                .onTap { [weak self] in
                    self?.onAuth?()
                }

            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(hInsets: 16))
    }
}
