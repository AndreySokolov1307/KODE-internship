import UIKit

public extension UIActivityIndicatorView {

    @discardableResult
    func color(_ uiColor: UIColor?) -> Self {
        if let uiColor {
            color = uiColor
        }
        return self
    }
}
