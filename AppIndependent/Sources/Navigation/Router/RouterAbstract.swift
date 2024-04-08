import UIKit

/// Higher priority than TransitionConfig
public protocol NavigationBarAlwaysHidden {}
public protocol NavigationBarAlwaysVisible {}
public protocol NavigationBarClearBackgroundWhenPush {}
public protocol NavigationBarWithoutItems {}
public protocol NavigationBarWithShadow {}
/// Identical controllers could be pushed one by one
public protocol AllowDuplicating {}

public protocol RouterAbstract: Presentable {

    var rootController: UINavigationController? { get }

    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?, transitionOptions: [TransitionOption])
    func pushToTop(_ module: Presentable?, transitionOptions: [TransitionOption])

    func set(modules: [Presentable], animated: Bool)

    func popModule()
    func popToModule(_ module: Presentable?, animated: Bool)
    func popModule(animated: Bool)
    func popToModule<T: Presentable>(_: T.Type, animated: Bool, failHandler: (() -> Void)?)

    /// Visually navigate back to given module in navigation stack
    func popAndReplaceModule(module: Presentable?)
    /// Visually navigate back to given module in navigation stack
    func popAndReplaceModule(module: Presentable?, transitionOptions: [TransitionOption])

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func dismissModule(_ module: Presentable?)
    func dismissModule(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func removeModule<T: Presentable>(_ module: T)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, transitionOptions: [TransitionOption])

    func replaceLast(_ module: Presentable?, transitionOptions: [TransitionOption])
    func popToRootModule(animated: Bool)

    func addAsChild(_ module: Presentable?)
    func add(_ submodule: Presentable?, asChildTo module: Presentable?)

    func contains<T>(_: T.Type) -> Bool
    func firstChild<T>(_: T.Type) -> T?
    func firstIndex<T>(_ : T.Type) -> Int?
}

public extension RouterAbstract {

    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    func push(_ module: Presentable?) {
        push(module, transitionOptions: [])
    }

    func set(modules: [Presentable]) {
        set(modules: modules, animated: true)
    }

    func dismissModule(_ module: Presentable?) {
        dismissModule(module, animated: true, completion: nil)
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func popModule() {
        popModule(animated: true)
    }

    func popToModule(_ module: Presentable?) {
        popToModule(module, animated: true)
    }

    func popToModule<T: Presentable>(_: T.Type, animated: Bool) {
        popToModule(T.self, animated: animated, failHandler: nil)
    }
    func popToModule<T: Presentable>(_: T.Type, failHandler: (() -> Void)?) {
        popToModule(T.self, animated: true, failHandler: failHandler)
    }
    func popToModule<T: Presentable>(_: T.Type) {
        popToModule(T.self, animated: true, failHandler: nil)
    }

    func popAndReplaceModule(module: Presentable?) {
        popAndReplaceModule(module: module, transitionOptions: [])
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, transitionOptions: [])
    }
}
