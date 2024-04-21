//
//  MainFlowCoordinator.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class MainFlowCoordinator: Coordinator {

    // MARK: - Private Properties

    private let appSession: AppSession = resolver ~> AppSession.self

    // MARK: - MainFlowCoordinator

    public convenience init(rootRouter: RouterAbstract) {
        self.init(router: rootRouter)
    }

    func mainController() -> UIViewController? {
        let controller = resolver ~> MainController.self
        
        controller.onEvent = { [weak self] event in
            switch event {
            case .accountDetail:
                self?.showAccountDetailController()
            case .cardDetail:
                self?.showCardDetailController()
            }
        }
        
        router.setRootModule(controller)
        return router.rootController
    }
    
    func showAccountDetailController() {
        let controller = resolver ~> AccountDetailController.self
        router.push(controller)
    }
    
    func showCardDetailController() {
        let controller = resolver ~> CardDetailController.self
        router.push(controller)
    }
}

