import UIKit

public extension UIView {

    func addSubview(_ subview: UIView, completion: (UIView) -> Void) {
        addSubview(subview)
        completion(subview)
    }
}
