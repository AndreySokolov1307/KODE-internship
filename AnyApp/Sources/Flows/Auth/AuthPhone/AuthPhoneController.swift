import UI
import UIKit
import AppIndependent

final class AuthPhoneController: TemplateViewController<AuthPhoneView>, NavigationBarAlwaysVisible {

    typealias ViewModel = AuthPhoneViewModel

    enum Event {
        case otp(AuthOtpConfigModel)
    }
    
    // MARK: - Public Properties

    var onEvent: ((Event) -> Void)?
    
    // MARK: - Private Properties

    private var viewModel: ViewModel!
    
    // MARK: - AuthPhoneController

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.state = .input
    }
    
    // MARK: - Private Methods

    private func setupBindings() {
        rootView.onAuth = { [weak self] number in
                self?.viewModel.handle(.phoneEntered(number))
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .otp(let configModel):
                self?.rootView.state = .input
                self?.onEvent?(.otp(configModel))
            case .invalidNumber:
                self?.showInvalidNumberSnack()
                self?.rootView.state = .error
            case .sendRequest:
                self?.rootView.state = .loading
            case .error(let message):
                self?.rootView.state = .input
                self?.showErrorSnack(with: message)
            }
        }
    }
    
    private func showInvalidNumberSnack() {
        SnackCenter.shared.showSnack(withProps: .init(
            message: Common.Error.wrongNumberFormat,
            style: .error,
            image: Asset.Images.close.image,
            onDismiss: { [weak self] in
                self?.rootView.state = .input
            }))
    }
}
