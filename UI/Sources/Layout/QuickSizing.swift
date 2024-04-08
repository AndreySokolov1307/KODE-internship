import UIKit

let moduleConstraintName = "CoreUI:constraint"

// MARK: - Equality

public extension UIView {

    /// Sets up constraint for height.
    @discardableResult
    func size(
        _ size: CGSize,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.size.equalTo(size).priority(priority)
        }
        return self
    }

    /// Sets up constraint for height.
    @discardableResult
    func size(
        sideLength: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        size(
            CGSize(width: sideLength, height: sideLength),
            priority: priority
        )
    }

    /// Sets up constraint for height.
    @discardableResult
    func size(
        width: CGFloat,
        height: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        size(
            CGSize(width: width, height: height),
            priority: priority
        )
    }
}

public extension UIView {

    /// Sets up constraint for height.
    @discardableResult
    func height(
        _ constant: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.height.equalTo(constant).priority(priority)
        }
        return self
    }

    /// Sets up constraint for width.
    @discardableResult
    func width(
        _ constant: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.width.equalTo(constant).priority(priority)
        }
        return self
    }
}

// MARK: - Greater than

public extension UIView {

    /// Sets up constraint for height.
    @discardableResult
    func minHeight(
        _ constant: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(constant).priority(priority)
        }
        return self
    }

    /// Sets up constraint for width.
    @discardableResult
    func minWidth(
        _ constant: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(constant).priority(priority)
        }
        return self
    }
}

// MARK: - Less than

public extension UIView {

    /// Sets up constraint for height.
    @discardableResult
    func maxHeight(
        _ constant: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.height.lessThanOrEqualTo(constant).priority(priority)
        }
        return self
    }

    /// Sets up constraint for width.
    @discardableResult
    func maxWidth(
        _ constant: CGFloat,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.width.lessThanOrEqualTo(constant).priority(priority)
        }
        return self
    }
}

// MARK: Other view equality

public extension UIView {

    @discardableResult
    func height(
        equalsToHeightOf view: UIView,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.height.equalTo(view.snp.height).multipliedBy(multiplier).priority(priority)
        }
        return self
    }

    @discardableResult
    func width(
        equalsToWidthOf view: UIView,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(multiplier).priority(priority)
        }
        return self
    }

    /// Sets up constraints for width and height, equal to width and height of the given view
    @discardableResult
    func size(
        equalTo view: UIView,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.size.equalTo(view.snp.size).multipliedBy(multiplier).priority(priority)
        }
        return self
    }
}
