import Swinject
import SwinjectAutoregistration
import UIKit.UIWindow
import AppIndependent
import Services
import UI
import Core

final class StartUpAssembly: Assembly, Identifiable {

    var id: String { String(describing: type(of: self)) }

    func assemble(container: Container) {

        container.register(BaseNavigationController.self) { _ in
            BaseNavigationController(navigationBarClass: BaseNavigationBar.self, toolbarClass: nil)
        }

        container.register(Router.self, name: RouterName.root) { resolver in
            let navigationController = resolver ~> BaseNavigationController.self
            return Router(rootController: navigationController)
        }

        container.register(AppCoordinator.self) { (resolver, window: UIWindow) in
            let persistent = (resolver ~> ServiceLayer.self).persistent
            let router = resolver ~> (Router.self, name: RouterName.root)
            let session = (resolver ~> ServiceLayer.self).session
            return AppCoordinator(
                router: router,
                session: session,
                persistent: persistent,
                window: window
            )
        }
//        .initCompleted { [unowned container] _, appCoordinator in
//            container.register(EventCenter.self) { _ in
//                EventCenter(coordinatorLayer: appCoordinator)
//            }
//            .inObjectScope(.container)
//        }
        .inObjectScope(.container)

        container.register(ServicesFactory.self) { resolver in
            return ServicesFactory()
        }.inObjectScope(.container)

        container.register(ServiceLayer.self) { resolver in
            let servicesFactory = resolver ~> ServicesFactory.self
            return servicesFactory.makeServiceLayer()
        }.inObjectScope(.container)

        container.register(AppSession.self) { resolver in
            (resolver ~> ServiceLayer.self).session
        }

        container.register(NetworkFactory.self) { resolver in
            let serviceLayer = resolver ~> ServiceLayer.self
            return NetworkFactory(network: serviceLayer.network)
        }.inObjectScope(.container)
    }

    func loaded(resolver: Resolver) {
        Logger().debug(String(describing: type(of: self)), "is loaded")
    }
}
