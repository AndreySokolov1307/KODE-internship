import UI
import Core
import Swinject
import Services
import AppIndependent
import SwinjectAutoregistration

final class HomeAssembly: Assembly, Identifiable {

    var id: String { String(describing: type(of: self)) }

    func assemble(container: Container) {
        container.autoregister(HomeFlowCoordinator.self, argument: RouterAbstract.self, initializer: HomeFlowCoordinator.init)

        container.register(TabController.self) { (_, controllers: [UIViewController]) in
            let tabController = TabController()
            tabController.setViewControllers(controllers, animated: true)
            return tabController
        }
    }

    func loaded(resolver: Resolver) {
        Logger().debug(id, "is loaded")
    }
}
