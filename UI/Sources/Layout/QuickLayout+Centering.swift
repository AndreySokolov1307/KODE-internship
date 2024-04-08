import UIKit
import SnapKit

public extension UIView {

    /// Pin to the center of given view
    func pinCenter(toCenterOf view: UIView) {
        pinCenterX(toCenterXOf: view)
        pinCenterY(toCenterYOf: view)
    }

    /// Pin to the center of given view at X axis
    func pinCenterX(toCenterXOf view: UIView) {
        snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
        }
    }

    /// Pin to the center of given view at Y axis
    func pinCenterY(toCenterYOf view: UIView) {
        snp.makeConstraints {
            $0.centerY.equalTo(view.snp.centerY)
        }
    }
}
