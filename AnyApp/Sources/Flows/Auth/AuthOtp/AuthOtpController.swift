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

//        rootView.otpTextFieldView.didEnterLastDigit = { [weak self] text in
//            print(text)
//            self?.viewModel.handle(.otpEntered)
//        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            }
        }
    }
}
