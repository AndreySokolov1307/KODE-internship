import UI
import Core
import Swinject
import Services
import AppIndependent
import SwinjectAutoregistration

final class ProfileFlowAssembly: Assembly, Identifiable {
    
    // MARK: - Public Properties

    var id: String { String(describing: type(of: self)) }
    
    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(NavigationController.self, name: RouterName.profile) { _ in
            NavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        }
        .inObjectScope(.weak)

        container.register(Router.self, name: RouterName.profile) { resolver in
            let navigationController = resolver ~> (NavigationController.self, name: RouterName.profile)
            return Router(rootController: navigationController)
        }
        .inObjectScope(.weak)

        container.register(ProfileFlowCoordinator.self) { resolver, router in
            let innerRouter = resolver ~> (Router.self, name: RouterName.profile)
            return ProfileFlowCoordinator(rootRouter: router, innerRouter: innerRouter)
        }

        container.register(ProfileController.self) { resolver in
            let viewModel = ProfileViewModel(
                appSession: resolver ~> AppSession.self,
                coreRequestManager: (resolver ~> NetworkFactory.self).makeCoreRequestManager()
            )
            return ProfileController(viewModel: viewModel)
        }
        
        container.register(AppThemeController.self) { _ in
            let viewModel = AppThemeViewModel()
            return AppThemeController(viewModel: viewModel)
        }
        
        container.register(AboutAppController.self) { _ in
            return AboutAppController()
        }
    }

    func loaded(resolver: Resolver) {
        Logger().debug(id, "is loaded")
    }
}
