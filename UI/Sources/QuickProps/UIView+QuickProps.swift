import UIKit.UIView

public extension UIView {

    /// View itself with disabled autoresizing mask translation
    @discardableResult
    func noMaskTranslation() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    @discardableResult
    func huggingPriority(_ priority: UILayoutPriority, axis: NSLayoutConstraint.Axis) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult
    func compressionResistance(_ priority: UILayoutPriority, axis: NSLayoutConstraint.Axis) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }

    @discardableResult
    func userInteraction(enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }

    @discardableResult
    func backgroundColor(_ uiColor: UIColor?) -> Self {
        backgroundColor = uiColor
        return self
    }

    @discardableResult
    func tintColor(_ uiColor: UIColor?) -> Self {
        tintColor = uiColor
        return self
    }

    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }

    @discardableResult
    func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func borderColor(_ uiColor: UIColor?) -> Self {
        layer.borderColor = uiColor?.cgColor
        return self
    }

    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        layer.shadowOffset = offset
        return self
    }

    @discardableResult
    func shadowOpacity(_ opacity: Float) -> Self {
        layer.shadowOpacity = opacity
        return self
    }

    @discardableResult
    func shadowRadius(_ radius: CGFloat) -> Self {
        layer.shadowRadius = radius
        return self
    }

    @discardableResult
    func shadowColor(_ uiColor: UIColor?) -> Self {
        layer.shadowColor = uiColor?.cgColor
        return self
    }

    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Self {
        self.layer.masksToBounds = masksToBounds
        return self
    }

    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }

    @discardableResult
    func shouldBecomeFirstResponder() -> Self {
        self.becomeFirstResponder()
        return self
    }
}
