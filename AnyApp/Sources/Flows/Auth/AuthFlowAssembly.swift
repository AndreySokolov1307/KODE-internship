import UI
import Core
import Swinject
import Services
import AppIndependent
import SwinjectAutoregistration

final class AuthFlowAssembly: Assembly, Identifiable {

    var id: String { String(describing: type(of: self)) }

    func assemble(container: Container) {
        container.autoregister(AuthFlowCoordinator.self, argument: RouterAbstract.self, initializer: AuthFlowCoordinator.init)

        container.register(AuthPhoneController.self) { resolver in
            let viewModel = AuthPhoneViewModel(authRequestManager: (resolver ~> NetworkFactory.self).makeAuthRequestManager())
            return AuthPhoneController(viewModel: viewModel)
        }

        container.register(AuthOtpController.self) { resolver in
            let viewModel = AuthOtpViewModel(
                authRequestManager: (resolver ~> NetworkFactory.self).makeAuthRequestManager(),
                appSession: resolver ~> AppSession.self
            )
            return AuthOtpController(viewModel: viewModel)
        }
    }

    func loaded(resolver: Resolver) {
        Logger().debug(id, "is loaded")
    }
}
