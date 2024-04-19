//
//  ProfileFlowCoordinator.swift
//  AnyApp
//
//  Created by Андрей Соколов on 18.04.2024.
//

import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration
import UI

final class ProfileFlowCoordinator: Coordinator {

    // MARK: - Private Properties
    private let appSession: AppSession = resolver ~> AppSession.self

    // MARK: - MainFlowCoordinator

    public convenience init(rootRouter: RouterAbstract) {
        self.init(router: rootRouter)
    }

    func profileController() -> UIViewController? {
        let controller = resolver ~> ProfileController.self
        
        controller.onEvent = { [weak self] event in
            switch event {
            case .appTheme:
                self?.showAppThemeController()
            }
        }
        
        router.setRootModule(controller)
        return router.rootController
    }
    
    private func showAppThemeController() {
        let controller = resolver ~> AppThemeController.self
        router.push(controller)
    }
}
