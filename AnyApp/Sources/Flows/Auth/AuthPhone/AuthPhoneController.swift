import UI
import UIKit

final class AuthPhoneController: TemplateViewController<AuthPhoneView> {

    typealias ViewModel = AuthPhoneViewModel

    enum Event {
        case otp(AuthOtpConfigModel)
    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
    }

    private func setupBindings() {
        rootView.onAuth = { [weak self] number in
            self?.viewModel.handle(.phoneEntered(number))
        }

        viewModel.onOutput = { [weak self] output in
            switch output {
            case .otp(let configModel):
                self?.rootView.handleInput(.right)
                self?.onEvent?(.otp(configModel))
            case .invalidNumber:
                SnackCenter.shared.showSnack(withProps: .init(message: Common.Error.wrongNumberFormat, style: .error, image: Asset.Images.close.image))
                
                self?.rootView.handleInput(.wrong)
            }
        }
    }
}
