import UI
import UIKit

final class AuthOtpController: TemplateViewController<AuthOtpView> {

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

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            case .wrongOtp(let otpAttemptsLeft):
                self?.rootView.updateUIWithAttemptsLeft(otpAttemptsLeft)
                //TODO: move to view model
                if otpAttemptsLeft <= 0 {
                    self?.showLogoutAllert()
                }
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
