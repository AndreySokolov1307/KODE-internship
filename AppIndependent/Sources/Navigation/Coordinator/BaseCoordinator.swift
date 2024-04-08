// swiftlint:disable final_class
/// Abstract coordinator class
open class BaseCoordinator: NSObject, CoordinatorAbstract {

    public typealias DefaultFinishHandler = () -> Void

    public var childCoordinators: [CoordinatorAbstract] = []

    open func start() {
        assertionFailure("\(String(describing: self)) `start` method must be implemented")
    }

    public func addDependency(_ coordinator: CoordinatorAbstract) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    public func removeDependency(_ coordinator: CoordinatorAbstract?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else { return }

        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: childCoordinators.count - index - 1)
            break
        }
    }

    public func removeDependency<T: CoordinatorAbstract>(of coordinatorType: T.Type) {
        guard !childCoordinators.isEmpty else {
            return
        }

        for (index, element) in childCoordinators.reversed().enumerated() where type(of: element) == coordinatorType {
            childCoordinators.remove(at: childCoordinators.count - index - 1)
            break
        }
    }

    public func removeAllDependencies() {
        childCoordinators.removeAll()
    }

    deinit {
        Logger().logDeinit(self)
    }
}

public extension BaseCoordinator {
    func contains<C: CoordinatorAbstract>(child _: C.Type) -> Bool {
        return childCoordinators.contains(where: { type(of: $0) == C.self })
    }

    func child<C: CoordinatorAbstract>(ofType _: C.Type) -> C? {
        return childCoordinators.first(where: { type(of: $0) == C.self }) as? C
    }
}
