//
//  MainFlowAssemply.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UI
import Core
import Swinject
import Services
import AppIndependent
import SwinjectAutoregistration

final class MainFlowAssembly: Assembly, Identifiable {

    var id: String { String(describing: type(of: self)) }

    func assemble(container: Container) {
        container.register(BaseNavigationController.self, name: RouterName.main) { _ in
            BaseNavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        }
        .inObjectScope(.weak)

        container.register(Router.self, name: RouterName.main) { resolver in
            let navigationController = resolver ~> (BaseNavigationController.self, name: RouterName.main)
            return Router(rootController: navigationController)
        }
        .inObjectScope(.weak)

        container.register(MainFlowCoordinator.self) { resolver in
            let router = resolver ~> (Router.self, name: RouterName.main)
            return MainFlowCoordinator(rootRouter: router)
        }

        container.register(MainController.self) { _ in
            let viewModel = MainViewModel()
            return MainController(viewModel: viewModel)
        }
        
        container.register(AccountDetailController.self) { _ in
            let viewModel = AccountDetailViewModel()
            return AccountDetailController(viewModel: viewModel)
        }
    }

    func loaded(resolver: Resolver) {
        Logger().debug(id, "is loaded")
    }
}
