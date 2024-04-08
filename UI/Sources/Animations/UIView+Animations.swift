import UIKit

public extension UIView {

    func fadeIn(
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration ?? 0,
            delay: delay,
            animations: alphaAnimation(to: 1),
            completion: wrapped(completion: then)
        )
    }

    func fadeOut(
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration ?? 0,
            delay: delay,
            animations: alphaAnimation(to: 0),
            completion: wrapped(completion: then)
        )
    }

    func moveHorizontally(
        distance: CGFloat,
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        move(
            distanceX: distance,
            distanceY: 0,
            duration: duration,
            delay: delay,
            then: then
        )
    }

    func moveVertically(
        distance: CGFloat,
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        move(
            distanceX: 0,
            distanceY: distance,
            duration: duration,
            delay: delay,
            then: then
        )
    }

    func move(
        distanceX: CGFloat,
        distanceY: CGFloat,
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration ?? 0,
            delay: delay,
            animations: moveAnimation(x: distanceX, y: distanceY),
            completion: wrapped(completion: then)
        )
    }

    func restoreTransform(
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration ?? 0,
            delay: delay,
            animations: identityTransformAnimation(),
            completion: wrapped(completion: then)
        )
    }

    func animateBackgroundColor(
        _ backgroundColor: UIColor,
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration ?? 0,
            delay: delay,
            animations: backgroundColorChangeAnimation(to: backgroundColor),
            completion: wrapped(completion: then)
        )
    }
}

public extension UIView {

    func rotationInfinite(turnDuration: TimeInterval = 1.0, animationName: String = "rotationAnimation") {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = CGFloat.pi * 2
        animation.duration = turnDuration
        animation.isCumulative = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: animationName)
    }
}

fileprivate extension UIView {

    func identityTransformAnimation() -> () -> Void {
        return { [weak self] in
            self?.transform = CGAffineTransform.identity
        }
    }

    func alphaAnimation(to alpha: CGFloat) -> () -> Void {
        return { [weak self] in
            self?.alpha = alpha
        }
    }

    func moveAnimation(x: CGFloat, y: CGFloat) -> () -> Void {
        return { [weak self] in
            self?.transform = CGAffineTransform.identity.translatedBy(x: x, y: y)
        }
    }

    func wrapped(completion: (() -> Void)?) -> ((Bool) -> Void)? {
        guard let completion = completion else {
            return nil
        }
        return { _ in
            completion()
        }
    }

    func backgroundColorChangeAnimation(to backgroundColor: UIColor) -> () -> Void {
        return { [weak self] in
            self?.backgroundColor = backgroundColor
        }
    }
}

public extension Array where Element == UIView {
    
    func fadeIn(
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        forEach {
            $0.fadeIn(duration: duration, delay: delay)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? 0) + delay) {
            then?()
        }
    }
    
    func fadeOut(
        duration: TimeInterval? = 0.2,
        delay: TimeInterval = 0,
        then: (() -> Void)? = nil
    ) {
        forEach {
            $0.fadeOut(duration: duration, delay: delay)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? 0) + delay) {
            then?()
        }
    }
}
