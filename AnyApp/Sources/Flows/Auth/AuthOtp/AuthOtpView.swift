import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?
    var otpTextFieldView = OTPTextFieldView()
    var label: Label {
        Label(text: Entrance.otpLabel)
            .fontStyle(.button)
            .numberOfLines(0)
    }

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            label
            Spacer(.px24)
            otpTextFieldView
            FlexibleSpacer()
            ButtonPrimary(title: "Авторизоваться")
                .onTap { [weak self] in
                    self?.onOtpFilled?()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}

