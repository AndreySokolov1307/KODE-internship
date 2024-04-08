import UIKit

public extension UIViewController {

    // swiftlint:disable:next final_class
    var className: String {
        return NSStringFromClass(classForCoder).components(separatedBy: ".").last ?? ""
    }
}
