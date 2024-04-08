import Swinject
import AppIndependent
import SwinjectAutoregistration

// swiftlint:disable:next final_class
open class Coordinator: BaseCoordinator, RoutableCoordinator {

    public static let resolver: Resolver = DIContainer.shared.resolver
    public let resolver: Resolver = DIContainer.shared.resolver

    public let router: RouterAbstract

    /// Deeplink to process later
    public var deferredDeeplink: Deeplink?

    public required init(router: RouterAbstract) {
        self.router = router
    }

    open func start(withDeeplink deeplink: Deeplink?) {
        if let deeplink = deeplink ?? deferredDeeplink {
            deferredDeeplink = nil
            start(withDeeplink: deeplink)
        } else {
            start()
        }
    }

    open func start(withDeeplink: Deeplink) {
        // ignore deeplink by default
        assertionFailure("Deeplink received, but not processed")
        start()
    }

    open func topController<T>(ofType _: T.Type) -> T? {
        return lastController() as? T
    }

    open func lastController() -> UIViewController? {
        router.rootController?.viewControllers.last
    }
}
