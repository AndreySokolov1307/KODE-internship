import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: StringHandler?
    let otpTextFieldView = OtpInputView()
    private let label = Label(text: Entrance.otpLabel, foregroundStyle: .textPrimary, fontStyle: .body2)
        .multiline()
    private let otpRepeatView = OtpRepeatView()

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
    
    public func stopTimer() {
        otpRepeatView.timer?.invalidate()
    }
    
    public func updateUIWithAttemptsLeft(_ attemptsLeft: Int) {
        let attemptString = Plurals.attemptsLeft(attemptsLeft)
        let leftString = Plurals.leftFem(attemptsLeft)
        otpTextFieldView.updateUIWithWrongInput()
        otpRepeatView.updateUIWithWrongInputMessage("Неверный код. \(leftString) \(attemptsLeft) " + attemptString)
    }
}

