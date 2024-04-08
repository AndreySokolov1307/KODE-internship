import UIKit

public extension UIEdgeInsets {

    static func all(_ inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    static func make(vInsets: CGFloat = 0, hInsets: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(top: vInsets, left: hInsets, bottom: vInsets, right: hInsets)
    }
}

public extension NSDirectionalEdgeInsets {

    static func all(_ inset: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
    }

    static func make(vInsets: CGFloat = 0, hInsets: CGFloat = 0) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: vInsets, leading: hInsets, bottom: vInsets, trailing: hInsets)
    }
}
