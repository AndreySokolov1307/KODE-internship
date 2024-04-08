import UIKit

public extension UIWindow {
    
    static let safeAreaInsets: UIEdgeInsets = {
        let window = UIApplication.currentWindow
        if #available(iOS 11.0, *) {
            return window?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }()
    
    static let safeAreaBottomInset: CGFloat = {
        safeAreaInsets.bottom
    }()
    
    static let safeAreaTopInset: CGFloat = {
        safeAreaInsets.top
    }()
}
