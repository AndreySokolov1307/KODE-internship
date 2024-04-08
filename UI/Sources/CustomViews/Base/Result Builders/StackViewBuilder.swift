import UIKit.UIStackView

#if swift(>=5.4)
@resultBuilder
// swiftlint:disable:next convenience_type
public struct StackViewBuilder {
    public static func buildBlock(_ args: UIView...) -> [UIView] {
        return args.filter { !($0 is BaseEmptyView) }
    }
}
#else
@_resultBuilder
// swiftlint:disable:next convenience_type
public struct StackViewBuilder {
    public static func buildBlock(_ args: UIView...) -> [UIView] {
        return args.filter { !($0 is BaseEmptyView) }
    }
}
#endif
