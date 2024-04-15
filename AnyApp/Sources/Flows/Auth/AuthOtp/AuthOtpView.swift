import UI
import UIKit
import AppIndependent

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: StringHandler?
    let otpTextFieldView = OTPTextFieldView()
    private let label = Label(text: Entrance.otpLabel, fontStyle: .body2)
        .multiline()
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
    
    public func stopTimer() {
        otpRepeatView.timer?.invalidate()
    }
    
    public func updateUIWithAttemptsLeft(_ attemptsLeft: Int) {
        var attemptString: String
        switch attemptsLeft {
        case 0:
            attemptString = "попыток"
        case 1:
            attemptString = "попытка"
        default:
            attemptString = "попытки"
        }
        
        var leftString: String
        switch attemptsLeft {
        case 1:
            leftString = "Осталась"
        default:
            leftString = "Осталось"
        }
        otpTextFieldView.updateUIWithWrongInput()
        otpRepeatView.updateUIWithWrongInputMessage("Неверный код. \(leftString) \(attemptsLeft) " + attemptString)
    }
}

