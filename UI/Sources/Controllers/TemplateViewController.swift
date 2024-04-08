import UIKit

// swiftlint:disable:next final_class
open class TemplateViewController<T: UIView>: ViewController {

    public var rootView: T { view as? T ?? T() }

    override open func loadView() {
        view = T()
    }
}
