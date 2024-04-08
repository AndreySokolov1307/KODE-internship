// Any object which can start some process (animation, loading, etc.) and stop it
public protocol StartStoppable: AnyObject {

    func start(completion: (() -> Void)?)
    func stop(completion: (() -> Void)?)
}

public extension StartStoppable {

    func start() {
        start(completion: nil)
    }

    func stop() {
        stop(completion: nil)
    }
}
