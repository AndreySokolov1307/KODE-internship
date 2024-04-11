import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?
    var otpTextFieldView = OTPTextFieldView()
    var label = Label(text: Entrance.otpLabel)
        .font(UIFont.systemFont(ofSize: 15, weight: .regular))
        .numberOfLines(0)
    var otpRepeatView = OTPRepeatView()

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            label
            Spacer(.px24)
            otpTextFieldView
            Spacer(.px24)
            otpRepeatView
            FlexibleSpacer()
            ButtonPrimary(title: "Авторизоваться")
                .onTap { [weak self] in
                    self?.onOtpFilled?()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}

