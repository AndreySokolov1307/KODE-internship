import UIKit

public extension UILabel {
    
    func fadedChange(
        text: String?,
        withDuration duration: TimeInterval
    ) {
        fadeOut(duration: duration) { [weak self] in
            self?.text = text
            self?.fadeIn(duration: duration)
        }
    }
    
    func fadedChange(
        _ transform: @escaping (UILabel?) -> Void,
        withDuration duration: TimeInterval
    ) {
        fadeOut(duration: duration) { [weak self] in
            transform(self)
            self?.fadeIn(duration: duration)
        }
    }
}
