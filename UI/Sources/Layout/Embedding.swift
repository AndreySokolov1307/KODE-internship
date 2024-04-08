import UIKit
import SnapKit

// MARK: - Embedding inside

public extension UIView {

    /// Add view inside the given view and pin edges with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func embed(
        in view: UIView,
        top topInset: CGFloat = 0,
        leading leadingInset: CGFloat = 0,
        bottom bottomInset: CGFloat = 0,
        trailing trailingInset: CGFloat = 0,
        useSafeAreaGuide: Bool = true,
        useMarginsGuide: Bool = false
    ) -> Self {
        view.addSubview(self)
        noMaskTranslation()
        pinEdges(
            inside: view,
            top: topInset,
            leading: leadingInset,
            bottom: bottomInset,
            trailing: trailingInset,
            useSafeAreaGuide: useSafeAreaGuide,
            useMarginsGuide: useMarginsGuide
        )
        return self
    }

    /// Add view inside the given view and pin edges with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func embed(in view: UIView, inset: CGFloat = 0, useSafeAreaGuide: Bool = true, useMarginsGuide: Bool = false) -> Self {
        embed(in: view, top: inset, leading: inset, bottom: inset, trailing: inset, useSafeAreaGuide: useSafeAreaGuide, useMarginsGuide: useMarginsGuide)
    }

    /// Add view inside the given view and pin edges with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func embed(in view: UIView, hInset: CGFloat = 0, vInset: CGFloat = 0, useSafeAreaGuide: Bool = true, useMarginsGuide: Bool = false) -> Self {
        embed(in: view, top: vInset, leading: hInset, bottom: vInset, trailing: hInset, useSafeAreaGuide: useSafeAreaGuide, useMarginsGuide: useMarginsGuide)
    }

    /// Add view inside the given view and pin to center
    @discardableResult
    func embedAtCenter(of view: UIView) -> Self {
        view.addSubview(self)
        noMaskTranslation()
        pinCenter(toCenterOf: view)
        return self
    }
}

// MARK: - Embedding other view

public extension UIView {

    /// Add given subview inside receiver view and pin edges with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func embed(
        subview: UIView,
        top topInset: CGFloat = 0,
        leading leadingInset: CGFloat = 0,
        bottom bottomInset: CGFloat = 0,
        trailing trailingInset: CGFloat = 0,
        useSafeAreaGuide: Bool = true,
        useMarginsGuide: Bool = false
    ) -> Self {
        subview.embed(
            in: self,
            top: topInset,
            leading: leadingInset,
            bottom: bottomInset,
            trailing: trailingInset,
            useSafeAreaGuide: useSafeAreaGuide,
            useMarginsGuide: useMarginsGuide
        )
        return self
    }

    /// Add given subview inside receiver view and pin edges with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func embed(subview: UIView, inset: CGFloat = 0, useSafeAreaGuide: Bool = true, useMarginsGuide: Bool = false) -> Self {
        embed(subview: subview, top: inset, leading: inset, bottom: inset, trailing: inset, useSafeAreaGuide: useSafeAreaGuide, useMarginsGuide: useMarginsGuide)
    }

    /// Add given subview inside receiver view and pin edges with insets.
    /// This method takes into account the relationship of the edges itself and adds a negative value to the inset if necessary
    @discardableResult
    func embed(subview: UIView, hInset: CGFloat = 0, vInset: CGFloat = 0, useSafeAreaGuide: Bool = true, useMarginsGuide: Bool = false) -> Self {
        embed(subview: subview, top: vInset, leading: hInset, bottom: vInset, trailing: hInset, useSafeAreaGuide: useSafeAreaGuide, useMarginsGuide: useMarginsGuide)
    }

    /// Add view inside the given view and pin to center
    @discardableResult
    func embedAtCenter(subview: UIView) -> Self {
        subview.embedAtCenter(of: self)
        return self
    }
}

public extension ScrollView {

    func embedScrollable(subview: UIView, padding: CGFloat = 0) {
        addSubview(subview)
        noMaskTranslation()

        let isVertical = axis == .vertical
        let verticalOffset = isVertical ? 0 : padding
        let horizontalOffset = isVertical ? padding : 0

        let constraints = [
            subview.leadingAnchor.constraint(
                equalTo: contentLayoutGuide.leadingAnchor,
                constant: horizontalOffset
            ),
            subview.trailingAnchor.constraint(
                equalTo: contentLayoutGuide.trailingAnchor,
                constant: -horizontalOffset
            ),
            subview.topAnchor.constraint(
                equalTo: contentLayoutGuide.topAnchor,
                constant: verticalOffset
            ),
            subview.bottomAnchor.constraint(
                equalTo: contentLayoutGuide.bottomAnchor,
                constant: -verticalOffset
            ),
            isVertical
            ? subview.widthAnchor.constraint(equalTo: widthAnchor, constant: -2 * padding)
            : subview.heightAnchor.constraint(equalTo: heightAnchor, constant: -2 * padding)
        ]
        addConstraints(constraints)
    }
}
