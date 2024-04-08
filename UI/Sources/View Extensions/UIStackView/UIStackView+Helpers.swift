import UIKit

public extension UIStackView {

    func add(arrangedSubviews subviews: [UIView]) {
        subviews.forEach {
            $0.willMove(toSuperview: self)
            addArrangedSubview($0)
            $0.didMoveToSuperview()
        }
    }

    func set(arrangedSubviews subviews: [UIView]) {
        removeArrangedSubviews()
        add(arrangedSubviews: subviews)
    }
    
    func add(arrangedSubviews subviews: [UIView?]) {
        add(arrangedSubviews: subviews.compactMap { $0 })
    }

    func set(arrangedSubviews subviews: [UIView?]) {
        removeArrangedSubviews()
        add(arrangedSubviews: subviews)
    }
    
    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.willMove(toSuperview: nil)
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func add(arrangedSubview subview: UIView?) {
        add(arrangedSubviews: [subview])
    }
    
    func child<T>(_ type: T.Type) -> T? {
        arrangedSubviews.first(where: { $0 is T }) as? T
    }
}
