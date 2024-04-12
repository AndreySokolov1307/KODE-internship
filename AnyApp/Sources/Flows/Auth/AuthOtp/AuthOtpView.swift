import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: StringHandler?
    let otpTextFieldView = OTPTextFieldView()
    private let label = Label(text: Entrance.otpLabel)
        .font(UIFont.systemFont(ofSize: 15, weight: .regular))
        .numberOfLines(0)
    private let otpRepeatView = OTPRepeatView()

    override func setup() {
        super.setup()
        body().embed(in: self)
        otpTextFieldView.didEnterLastDigit = { [weak self] otp in
            self?.onOtpFilled?(otp)
        }
    }

    private func body() -> UIView {
        VStack {
            label
            Spacer(.px24)
            otpTextFieldView
            Spacer(.px24)
            otpRepeatView
            FlexibleSpacer()
            
            // MARK: - dont need to use this
//            ButtonPrimary(title: "Авторизоваться")
//                .onTap { [weak self] in
//                    self?.onOtpFilled?("")
//                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
    
    func stopTimer() {
        otpRepeatView.timer?.invalidate()
    }
}

