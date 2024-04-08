import UIKit

#if swift(>=5.4)
@resultBuilder
public struct ScrollViewBuilder {
    public static func buildBlock(_ arg: UIView) -> UIView {
        return arg
    }
}
#else
@_resultBuilder
public struct ScrollViewBuilder {
    public static func buildBlock(_ arg: UIView) -> UIView {
        return arg
    }
}
#endif
