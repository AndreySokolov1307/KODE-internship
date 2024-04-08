import UIKit
import SnapKit

public extension UIView {

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinLeading(
        toLeadingOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinLeading(
        toTrailingOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.leading.equalTo(view.snp.trailing).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinTrailing(
        toLeadingOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.trailing.equalTo(view.snp.leading).inset(-inset).priority(priority)
        }
        return self
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinTrailing(
        toTrailingOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin horizontal edges to the same horizontal edges of the given view with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinHorizontalEdges(
        to view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        pinLeading(toLeadingOf: view, inset: inset, priority: priority)
        pinTrailing(toTrailingOf: view, inset: inset, priority: priority)
        return self
    }
}
