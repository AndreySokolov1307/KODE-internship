import UIKit

public struct ShadowProps {
    let radius: CGFloat
    let color: UIColor
    let offsetX: CGFloat
    let offsetY: CGFloat
}

public extension UIView {

    @discardableResult
    func shadow(_ shadowProps: ShadowProps) -> Self {
        setShadow(
            radius: shadowProps.radius,
            color: shadowProps.color,
            offsetX: shadowProps.offsetX,
            offsetY: shadowProps.offsetY
        )
        return self
    }
}
