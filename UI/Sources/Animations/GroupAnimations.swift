import UIKit

func groupAnimation(
    _ views: [UIView],
    animation: @escaping () -> Void,
    duration: TimeInterval? = 0.2,
    delay: TimeInterval = 0,
    then: (() -> Void)? = nil
) {
    UIView.animate(
        withDuration: duration ?? 0,
        delay: delay,
        animations: {
            animation()
        },
        completion: { _ in
            then?()
        }
    )
}

func groupFadeIn(
    _ views: [UIView],
    duration: TimeInterval? = 0.2,
    delay: TimeInterval = 0,
    then: (() -> Void)? = nil
) {
    UIView.animate(
        withDuration: duration ?? 0,
        delay: delay,
        animations: {
            views.forEach {
                $0.alpha = 1
            }
        },
        completion: { _ in
            then?()
        }
    )
}

func groupFadeOut(
    _ views: [UIView],
    duration: TimeInterval? = 0.2,
    delay: TimeInterval = 0,
    then: (() -> Void)? = nil
) {
    UIView.animate(
        withDuration: duration ?? 0,
        delay: delay,
        animations: {
            views.forEach {
                $0.alpha = 0
            }
        },
        completion: { _ in
            then?()
        }
    )
}
