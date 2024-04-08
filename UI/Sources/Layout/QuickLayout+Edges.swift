import UIKit
import AppIndependent

public extension UIView {

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary.
    /// `useMarginsGuide` pins to `layoutMarginsGuide` instead of edges.
    /// `useSafeAreaGuide` pins to `safeAreaLayoutGuide` instead of edges.
    /// `useMarginsGuide` have higher priority, than `useSafeAreaGuide`
    @discardableResult
    func pinEdges(
        inside view: UIView,
        top topInset: CGFloat = 0,
        leading leadingInset: CGFloat = 0,
        bottom bottomInset: CGFloat = 0,
        trailing trailingInset: CGFloat = 0,
        useSafeAreaGuide: Bool = true,
        useMarginsGuide: Bool = false
    ) -> Self {
        noMaskTranslation()

        snp.makeConstraints {
            if useMarginsGuide {
                $0.top.equalTo(view.layoutMarginsGuide.snp.top).inset(topInset)
                $0.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(bottomInset)
                $0.leading.equalTo(view.layoutMarginsGuide.snp.leading).inset(leadingInset)
                $0.trailing.equalTo(view.layoutMarginsGuide.snp.trailing).inset(trailingInset)
            } else if useSafeAreaGuide {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(topInset)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(bottomInset)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(leadingInset)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(trailingInset)
            } else {
                $0.top.equalToSuperview().inset(topInset)
                $0.bottom.equalToSuperview().inset(bottomInset)
                $0.leading.equalToSuperview().inset(leadingInset)
                $0.trailing.equalToSuperview().inset(trailingInset)
            }
        }
        return self
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinEdges(inside view: UIView, inset: CGFloat = 0, useMarginsGuide: Bool = false) -> Self {
        pinEdges(inside: view, top: inset, leading: inset, bottom: inset, trailing: inset, useMarginsGuide: useMarginsGuide)
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinEdges(inside view: UIView, hInset: CGFloat = 0, vInset: CGFloat = 0, useMarginsGuide: Bool = false) -> Self {
        pinEdges(inside: view, top: vInset, leading: hInset, bottom: vInset, trailing: hInset, useMarginsGuide: useMarginsGuide)
    }

    /// Pin edges with given insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinEdges(inside view: UIView, insets: UIEdgeInsets, useMarginsGuide: Bool = false) -> Self {
        pinEdges(inside: view, top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right, useMarginsGuide: useMarginsGuide)
    }
}

// MARK: - Pin inside superview

public extension UIView {

    /// Pin edges to superview edges with given insets.
    /// Do nothing if superview is not exist.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinToSuperviewEdges(
        top topInset: CGFloat = 0,
        leading leadingInset: CGFloat = 0,
        bottom bottomInset: CGFloat = 0,
        trailing trailingInset: CGFloat = 0
    ) -> Self {
        guard let superview else {
            Logger().error("Failed to pin view to the superview: superview is nil")
            return self
        }
        return pinEdges(
            inside: superview,
            top: topInset,
            leading: leadingInset,
            bottom: bottomInset,
            trailing: trailingInset
        )
    }

    /// Pin edges to superview edges with given insets.
    /// Do nothing if superview is not exist.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinToSuperviewEdges(insets: UIEdgeInsets) -> Self {
        pinToSuperviewEdges(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
    }

    /// Pin edges to superview edges with given insets.
    /// Do nothing if superview is not exist.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinToSuperviewEdges(inset: CGFloat = 0) -> Self {
        pinToSuperviewEdges(top: inset, leading: inset, bottom: inset, trailing: inset)
    }

    /// Pin edges to superview edges with given insets.
    /// Do nothing if superview is not exist.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func pinToSuperviewEdges(hInset: CGFloat = 0, vInset: CGFloat = 0) -> Self {
        pinToSuperviewEdges(top: vInset, leading: hInset, bottom: vInset, trailing: hInset)
    }
}
