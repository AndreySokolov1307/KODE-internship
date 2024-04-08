import UIKit

public extension UIApplication {

    class var currentWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication
                .shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last
        } else {
            return UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .last { $0.isKeyWindow }
        }
    }

    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle? {
        return Self.currentWindow?.traitCollection.userInterfaceStyle
    }
}
