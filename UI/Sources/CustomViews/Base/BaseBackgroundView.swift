import UIKit
import SnapKit

#if swift(>=5.4)
@resultBuilder
// swiftlint:disable:next convenience_type
public struct BackgroundViewBuilder {
    public static func buildBlock(_ arg: UIView) -> UIView {
        return arg
    }
}
#else
@_resultBuilder
// swiftlint:disable:next convenience_type
public struct BackgroundViewBuilder {
    public static func buildBlock(_ arg: UIView) -> UIView {
        return arg
    }
}
#endif

// swiftlint:disable:next final_class
open class BaseBackgroundView: BaseView {

    public convenience init(vPadding: CGFloat = 0, hPadding: CGFloat = 0,
                            @BackgroundViewBuilder content: () -> UIView) {
        self.init(frame: .zero)
        let subview = content()
        addSubview(subview)
        subview.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(hPadding)
            $0.top.bottom.equalToSuperview().inset(vPadding)
        }
    }

    public convenience init(leftPadding: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat,
                            @BackgroundViewBuilder content: () -> UIView) {
        self.init(frame: .zero)
        let subview = content()
        addSubview(subview)
        subview.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(leftPadding)
            $0.top.equalToSuperview().inset(top)
            $0.trailing.equalToSuperview().inset(right)
            $0.bottom.equalToSuperview().inset(bottom)
        }
    }

    public convenience init(
        padding: CGFloat,
        @BackgroundViewBuilder content: () -> UIView
    ) {
        self.init(frame: .zero)
        let subview = content()
        addSubview(subview)
        subview.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(padding)
        }
    }
}
