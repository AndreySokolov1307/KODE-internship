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

    private let innerRouter: RouterAbstract
    
    // MARK: - MainFlowCoordinator

    public init(
        rootRouter: RouterAbstract,
        innerRouter: RouterAbstract) {
            self.innerRouter = innerRouter
            super.init(router: rootRouter)
        }
    
    required init(router: RouterAbstract) {
        fatalError("init(router:) has not been implemented")
    }
    
    func mainController() -> UIViewController? {
        let controller = resolver ~> MainController.self
        innerRouter.setRootModule(controller)
        
        controller.onEvent = { [weak self] event in
            switch event {
            case .accountDetail:
                self?.showAccountDetailController()
            case .cardDetail:
                self?.showCardDetailController()
            }
        }
        
        return innerRouter.rootController
    }
    
    func showAccountDetailController() {
        let controller = resolver ~> AccountDetailController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
    
    func showCardDetailController() {
        let controller = resolver ~> CardDetailController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
}

