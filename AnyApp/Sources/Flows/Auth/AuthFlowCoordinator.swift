import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class AuthFlowCoordinator: Coordinator {
    
    enum Event {
        case userLoggedIn
    }
    
    // MARK: - Public Properties

    var onEvent: ((Event) -> Void)?

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self

    // MARK: - AuthFlowCoordinator

    required init(router: RouterAbstract) {
        super.init(router: router)
    }

    override func start() {
        showPhoneAuth()
    }
    
    // MARK: - Private Methods

    private func showPhoneAuth() {
        let controller = resolver ~> AuthPhoneController.self

        controller.onEvent = { [weak self] event in
            switch event {
            case .otp(let configModel):
                self?.showOtp(with: configModel)
            }
        }
        router.setRootModule(controller)
    }

    private func showOtp(with configModel: AuthOtpConfigModel) {
        let controller = resolver ~> (AuthOtpController.self, configModel)

        controller.onEvent = { [weak self] event in
            switch event {
            case .userLoggedIn:
                self?.onEvent?(.userLoggedIn)
            }
        }

        router.push(controller)
    }
}
