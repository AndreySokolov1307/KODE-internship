import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    var onLogout: VoidHandler?

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            FlexibleSpacer()
            Spacer(.px32)
            ButtonPrimary(title: "Разлогиниться")
                .onTap { [weak self] in
                    self?.onLogout?()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}
