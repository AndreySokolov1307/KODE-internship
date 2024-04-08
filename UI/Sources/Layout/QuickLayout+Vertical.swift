import UIKit
import SnapKit

public extension UIView {

    /// Pin top edge with given inset.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinTop(
        toTopOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.top.equalTo(view.snp.top).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin top edge with given inset.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinTop(
        toBottomOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin bottom edges with given inset.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinBottom(
        toTopOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin bottom edge with given inset.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinBottom(
        toBottomOf view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        noMaskTranslation()
        snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin vertical edges to the same vertical edges of the given view with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinVerticalEdges(
        to view: UIView,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        pinTop(toTopOf: view, inset: inset, priority: priority)
        pinBottom(toBottomOf: view, inset: inset, priority: priority)
        return self
    }
}

public extension UIView {

    /// Pin top edge with given inset.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinTopToSafeArea(
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        guard let superview else {
            return self
        }
        noMaskTranslation()
        snp.makeConstraints {
            $0.top.equalTo(superview.safeAreaLayoutGuide.snp.top).inset(inset).priority(priority)
        }
        return self
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinBottomToSafeArea(
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> Self {
        guard let superview else {
            return self
        }
        snp.makeConstraints {
            $0.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottom).inset(inset).priority(priority)
        }
        return self
    }
}
