import UIKit.UIStackView

public extension UIStackView {

    @discardableResult
    func adding(arrangedSubviews subviews: UIView...) -> Self {
        subviews.forEach { subview in
            subview.willMove(toSuperview: self)
            addArrangedSubview(subview)
            subview.didMoveToSuperview()
        }
        return self
    }

    @discardableResult
    func adding(arrangedSubviews subviews: [UIView]) -> Self {
        subviews.forEach { subview in
            subview.willMove(toSuperview: self)
            addArrangedSubview(subview)
            subview.didMoveToSuperview()
        }
        return self
    }

    @discardableResult
    func layoutMarginsRelativeArrangement(_ isLayoutMarginsRelativeArrangement: Bool) -> Self {
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }

}
