import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            FlexibleSpacer()
            Spacer(.px32)
            ButtonPrimary(title: "Авторизоваться")
                .onTap { [weak self] in
                    self?.onOtpFilled?()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}
