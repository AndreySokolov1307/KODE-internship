import UIKit
import AppIndependent

// swiftlint:disable:next final_class
open class BasePageViewController: UIPageViewController {

    // MARK: - Life Cycle

    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    open func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }

    open func updateAppearance() { }

    deinit {
        Logger().logDeinit(self)
    }
}
