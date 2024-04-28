import UI
import UIKit
import AppIndependent

final class AuthOtpController: TemplateViewController<AuthOtpView>, NavigationBarAlwaysVisible {

    typealias ViewModel = AuthOtpViewModel

    enum Event {
        case userLoggedIn
    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rootView.stopTimer()
    }

    override func setup() {
        super.setup()
        setupBindings()
    }

    private func setupBindings() {
        rootView.onOtpFilled = { [weak self] otp in
            self?.viewModel.handle(.otpEntered(otp))
        }
        
        rootView.onOtpRepeat = { [weak self] in
            self?.viewModel.handle(.otpRepeat)
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            case .wrongOtp(let otpAttemptsLeft):
                self?.rootView.state = .error(otpAttemptsLeft)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self?.rootView.state = .input
                }
            case .zeroAttemptsLeft:
                self?.showLogoutAllert()
            case .error(let message):
                self?.showErrorSnack(with: message)
            }
        }
    }
    
    private func showLogoutAllert() {
        let logOutAction = UIAlertAction(
            title: Common.quit,
            style: .default,
            handler: { _ in
                self.viewModel.handle(.logout)
            })
        presentAlert(title: Entrance.Error.wrongInputTitle,
                     message: Entrance.Error.worngInputMessage,
                     actions: [logOutAction])
    }
}
