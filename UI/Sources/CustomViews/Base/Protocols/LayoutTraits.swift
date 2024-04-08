import UIKit

/// `BaseStatefullView` will layout this view to the full size ignoring `safeAreaLayoutGuide`
public protocol IgnoreSafeArea: IgnoreSafeAreaTop, IgnoreSafeAreaBottom { }
public protocol IgnoreSafeAreaTop { }
public protocol IgnoreSafeAreaBottom { }

/// `BaseStatefullView` will insert this view as a lower subview instead of adding on top
public protocol BottomSubview { }
public protocol BottomSubviewWithExceptions: BottomSubview {
    var exceptions: [UIView.Type] { get }
}
