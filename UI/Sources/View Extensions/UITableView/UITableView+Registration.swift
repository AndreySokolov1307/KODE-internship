import UIKit

public extension UITableView {

    func register<T: UITableViewCell>(cellClass: T.Type) {
        let cellReuseIdentifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: cellReuseIdentifier)
    }

    func registerTemplateCell<V: UIView>(forView _: V.Type) {
        register(cellClass: TableCellTemplate<V>.self)
    }
}
