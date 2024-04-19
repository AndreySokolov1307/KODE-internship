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

    // MARK: - ProfileFlowCoordinator

    public convenience init(rootRouter: RouterAbstract) {
        self.init(router: rootRouter)
    }

    func profileController() -> UIViewController? {
        let controller = resolver ~> ProfileController.self
        
        controller.onEvent = { [weak self] event in
            switch event {
            case .appTheme:
                self?.showAppThemeController()
            case .callSupport:
                self?.callSupport()
            case .about:
                self?.showAboutAppController()
            }
        }
        
        router.setRootModule(controller)
        return router.rootController
    }
    
    private func showAppThemeController() {
        let controller = resolver ~> AppThemeController.self
        router.push(controller)
    }
    
    private func showAboutAppController() {
        let controller = resolver ~> AboutAppController.self
        router.push(controller)
    }
    
    private func callSupport() {
        guard let url = URL(string: "tel://88000000000"),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
