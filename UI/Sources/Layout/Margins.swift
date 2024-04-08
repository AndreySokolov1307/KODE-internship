import UIKit

public extension UIView {

    @discardableResult
    func layoutMargins(_ insets: UIEdgeInsets) -> Self {
        (self as? UIStackView)?.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    func directionalLayoutMargins(_ insets: NSDirectionalEdgeInsets) -> Self {
        self.directionalLayoutMargins = insets
        return self
    }
}
