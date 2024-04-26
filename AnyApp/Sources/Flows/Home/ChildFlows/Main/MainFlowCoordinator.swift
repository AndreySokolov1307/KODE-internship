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
            case .accountDetail(let configModel):
                self?.showAccountDetailController(with: configModel)
            case .cardDetail(let configModel):
                self?.showCardDetailController(with: configModel)
            }
        }
        
        return innerRouter.rootController
    }
    
    func showAccountDetailController(with configModel: AccountDetailConfigModel) {
        let controller = resolver ~> (AccountDetailController.self, configModel)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
    
    func showCardDetailController(with configModel: CardDetailConfigModel) {
        let controller = resolver ~> (CardDetailController.self, configModel)
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
}

