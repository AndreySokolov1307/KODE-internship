import UI
import Core
import Services
import Swinject
import AppIndependent
import SwinjectAutoregistration

final class HomeFlowCoordinator: Coordinator {
    
    // MARK: - HomeFlowCoordinator

    required init(router: RouterAbstract) {
        super.init(router: router)
    }
    
    // MARK: - Public Methods

    override func start() {
        showTabController()
    }
    
    // MARK: - Private Methods

    private func showTabController() {
        guard topController(ofType: TabController.self) == nil else { return }

        guard let mainController = createMainController() else {
            fatalError("Error during initialization of MainController")
        }
        
        mainController.tabBarItem = .init(
            title: Main.main,
            image: Asset.Images.mainProduct.image,
            selectedImage: Asset.Images.mainProduct.image
        )

        guard let profileController = createProfileController() else {
            fatalError("Error during initialization of ProfileController")
        }
        
        profileController.tabBarItem = .init(title: Profile.profile,
                                             image: Asset.Images.profile.image,
                                             selectedImage: Asset.Images.profile.image)

        let controllers = [
            mainController,
            profileController
        ]

        let tabController = resolver ~> (TabController.self, controllers)

        router.setRootModule(tabController)
    }
}

private extension HomeFlowCoordinator {

    func createMainController() -> UIViewController? {
        DIContainer.shared.assemble(assembly: MainFlowAssembly())

        let coordinator = resolver ~> (MainFlowCoordinator.self, router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        addDependency(coordinator)

        return coordinator.mainController()
    }

    func createProfileController() -> UIViewController? {
        DIContainer.shared.assemble(assembly: ProfileFlowAssembly())
        
        let coordinator = resolver ~> (ProfileFlowCoordinator.self, router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        addDependency(coordinator)
        
        return coordinator.profileController()
    }
}
