import UIKit.UIControl

public extension UIControl {

    @discardableResult
    func isEnabled(_  isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> Void) -> Self {
        addAction(UIAction { _ in closure() }, for: controlEvents)
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func onTap(_ closure: @escaping () -> Void) -> Self {
        addAction(for: .touchUpInside, closure)
        return self
    }

    @discardableResult
    func addTarger(target: Any?, action: Selector, for event: UIControl.Event) -> Self {
        addTarget(target, action: action, for: event)
        return self
    }
}
