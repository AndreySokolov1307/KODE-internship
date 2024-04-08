import UIKit

public extension UIView {

    func parent<T>(ofType _: T.Type) -> T? {
        guard let superview else {
            return nil
        }
        if let parent = superview as? T {
            return parent
        }
        return superview.parent(ofType: T.self)
    }

    func firstChild<T>(ofType _: T.Type, recursive: Bool = true) -> T? {
        for subview in subviews {
            if let child = subview as? T {
                return child
            }
            if recursive, let child = subview.firstChild(ofType: T.self, recursive: recursive) {
                return child
            }
        }
        return nil
    }

    func firstChild(where predicate: @escaping (UIView) -> Bool, recursive: Bool = true) -> UIView? {
        for subview in subviews {
            if predicate(subview) {
                return subview
            }
            if recursive, let child = subview.firstChild(where: predicate, recursive: recursive) {
                return child
            }
        }
        return nil
    }

    func children<T>(ofType _: T.Type, recursive: Bool = true) -> [T] {
        var children: [T] = []
        for subview in subviews {
            if let child = subview as? T {
                children.append(child)
            }
            if recursive {
                let innerChildren = subview.children(ofType: T.self, recursive: recursive)
                children.append(contentsOf: innerChildren)
            }
        }
        return children
    }

    func children(where predicate: @escaping (UIView) -> Bool, recursive: Bool = true) -> [UIView] {
        var children: [UIView] = []
        for subview in subviews {
            if predicate(subview) {
                children.append(subview)
            }
            if recursive {
                let innerChildren = subview.children(where: predicate, recursive: recursive)
                children.append(contentsOf: innerChildren)
            }
        }
        return children
    }
}
