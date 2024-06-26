import UI
import UIKit
import AppIndependent

final class AuthOtpController: TemplateViewController<AuthOtpView>, NavigationBarAlwaysVisible {

    typealias ViewModel = AuthOtpViewModel

    enum Event {
        case userLoggedIn
    }

    // MARK: - Public Properties
    
    var onEvent: ((Event) -> Void)?
    
    // MARK: - Private Properties

    private var viewModel: ViewModel!
    
    // MARK: - AuthOtpController

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
    
    // MARK: - Private Methods

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
                self?.removeAdditionalState()
                self?.onEvent?(.userLoggedIn)
            case .wrongOtp(let otpAttemptsLeft):
                self?.rootView.state = .error(otpAttemptsLeft)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self?.rootView.state = .input
                }
            case .zeroAttemptsLeft:
                self?.showLogoutAllert()
            case .error(let message):
                self?.removeAdditionalState()
                self?.showErrorSnack(with: message)
            case .loading:
                self?.setAdditionState(.loading)
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
