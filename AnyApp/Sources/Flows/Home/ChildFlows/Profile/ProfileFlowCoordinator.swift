import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration
import UI

final class ProfileFlowCoordinator: Coordinator {
    
    // MARK: - Public Properties

    var finishFlow: DefaultFinishHandler?
    
    // MARK: - Private Properties
    
    private let appSession: AppSession = resolver ~> AppSession.self
    
    private let innerRouter: RouterAbstract

    // MARK: - ProfileFlowCoordinator
    
    public init(rootRouter: RouterAbstract,
                innerRouter: RouterAbstract) {
        self.innerRouter = innerRouter
        super.init(router: rootRouter)
    }
    
    required init(router: RouterAbstract) {
        fatalError("init(router:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func profileController() -> UIViewController? {
        let controller = resolver ~> ProfileController.self
        innerRouter.setRootModule(controller)
    
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
        
        return innerRouter.rootController
    }
    
    // MARK: - Private Methods
    
    private func showAppThemeController() {
        let controller = resolver ~> AppThemeController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
    
    private func showAboutAppController() {
        let controller = resolver ~> AboutAppController.self
        controller.hidesBottomBarWhenPushed = true
        innerRouter.push(controller)
    }
    
    // TODO: - move to view model
    private func callSupport() {
        guard let url = URL(string: "tel://88000000000"),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
