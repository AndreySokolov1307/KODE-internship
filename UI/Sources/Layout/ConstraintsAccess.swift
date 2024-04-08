import UIKit

public extension UIView {

    var heightConstraint: NSLayoutConstraint? {
        constraints.first(where: { $0.firstAttribute == .height })
    }

    var widthConstraint: NSLayoutConstraint? {
        constraints.first(where: { $0.firstAttribute == .width })
    }
}

public extension NSLayoutConstraint {

    // Compare constraints, ignoring constant, multiplier and priority
    func isSame(as constraint: NSLayoutConstraint) -> Bool {
        guard
            firstAttribute == constraint.firstAttribute,
            secondAttribute == constraint.secondAttribute,
            firstItem === constraint.firstItem,
            secondItem === constraint.secondItem,
            relation == constraint.relation
        else {
            return false
        }
        return true
    }
}
