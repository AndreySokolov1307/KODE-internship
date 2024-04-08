import Foundation
import UIKit

public struct KeyboardChangeProps {

    public let targetFrame: CGRect
    public let animationDuration: TimeInterval?
    public let animationCurveRawValue: UInt?
}

public protocol KeyboardChangeListener: AnyObject {

    func listenKeyboardChanges()
    func keyboardChanged(_ props: KeyboardChangeProps)
}

public extension KeyboardChangeListener {

    func listenKeyboardChanges() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.handleKeyboardNotification(notification)
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.handleKeyboardNotification(notification)
        }
    }

    private func handleKeyboardNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame: CGRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let isKeyboardShowing: Bool = notification.name == UIResponder.keyboardWillShowNotification

        let props = KeyboardChangeProps(
            targetFrame: isKeyboardShowing ? keyboardFrame : .zero,
            animationDuration: duration,
            animationCurveRawValue: curve
        )

        keyboardChanged(props)
    }
}

public extension KeyboardChangeProps {

    var targetHeight: CGFloat { targetFrame.height }

    /// Animate with duration and curve from keyboard change event.
    /// If keyboard event have no duration, take 0
    /// If keyboard event have no curve, take `.easeInOut`
    func animate(_ animations: @escaping () -> Void) {
        UIView.animate(
            withDuration: animationDuration ?? 0,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: animationCurveRawValue ?? 0),
            animations: animations
        )
    }

    /// Run `layoutIfNeeded()` with duration and curve from keyboard change event.
    /// If keyboard event have no duration, take 0
    /// If keyboard event have no curve, take `.easeInOut`
    func animateLayoutIfNeeded(view: UIView) {
        animate {
            view.layoutIfNeeded()
        }
    }
}
