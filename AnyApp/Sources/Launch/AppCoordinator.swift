import UIKit
import AppIndependent
import Swinject
import SwinjectAutoregistration
import Services
import Combine
import Core
import UI

final class AppCoordinator: BaseCoordinator {

    var window: UIWindow
    var router: RouterAbstract
    let persistent: Persistent
    let resolver: Resolver

    private let session: AppSession
    private var cancellables = Set<AnyCancellable>()

    var isLogged = false

    #if DEV || INT
    var firstStart = true
    #else
    var firstStart = false
    #endif

    init(
        router: Router,
        session: AppSession,
        persistent: Persistent,
        window: UIWindow
    ) {
        self.session = session
        self.persistent = persistent
        self.window = window
        self.router = router

        resolver = DIContainer.shared.resolver

        super.init()

        // Only after checking first launch!
        saveLastUsedAppVersion()

        if window.isKeyWindow == false {
            window.rootViewController = router.rootController
            window.makeKeyAndVisible()
        }

        setupBindings()
    }

    override func start() {
        Logger().debug("AppCoordinator start")
        if session.isLoggedIn {
            runHomeFlow()
        } else {
            runAuthFlow()
        }
    }

    private func runAuthFlow() {
        DIContainer.shared.assemble(assembly: AuthFlowAssembly())
        let coordinator = resolver ~> (AuthFlowCoordinator.self, router)

        coordinator.onEvent = { [weak self] event in
            switch event {
            case .userLoggedIn:
                self?.start()
            }
        }

        addDependency(coordinator)
        coordinator.start()
    }

    private func runHomeFlow() {
        DIContainer.shared.assemble(assembly: HomeAssembly())
        let coordinator = resolver ~> (HomeFlowCoordinator.self, router)

        addDependency(coordinator)
        coordinator.start()
    }

    private func saveLastUsedAppVersion() {
        persistent.set(.lastUsedAppVersion(GlobalConstant.appVersion ?? "0.1"))
    }

    private func setupBindings() {
        session.$event.dropFirst().sink { [weak self] event in
            switch event {
            case .logout(let alert):
                switch alert {
                case .snack(let message):
                    SnackCenter.shared.showSnack(withProps: .init(message: message))
                default:
                    break
                }
                self?.removeAllDependencies()
                self?.start()
            default:
                break
            }
        }.store(in: &cancellables)
    }
}
