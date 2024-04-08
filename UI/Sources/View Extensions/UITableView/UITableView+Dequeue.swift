import UIKit

public extension UITableView {

    func dequeueCell<T: UITableViewCell>(
        forCellClass cellClass: T.Type,
        for indexPath: IndexPath,
        configure: ((T) -> Void)? = nil
    ) -> UITableViewCell {
        let cellReuseIdentifier = String(describing: cellClass)
        let cell = dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! T
        configure?(cell)
        return cell
    }

    func dequeueTemplateCell<V: UIView>(
        forView _: V.Type,
        for indexPath: IndexPath,
        configure: (((view: V, cell: TableCellTemplate<V>)) -> Void)? = nil
    ) -> TableCellTemplate<V> {
        if let cell = dequeueCell(forCellClass: TableCellTemplate<V>.self, for: indexPath) as? TableCellTemplate<V> {
            configure?((view: cell.view, cell: cell))
            return cell
        } else {
            assertionFailure("Unable to dequeue template table cell")
            return TableCellTemplate<V>()
        }
    }
}

public extension UITableView {
    
    func dequeueCell<T: UITableViewCell>(
        forCellClass cellClass: T.Type,
        for indexPath: IndexPath,
        withModel model: T.Model
    ) -> UITableViewCell where T: ConfigurableView {
        let cellReuseIdentifier = String(describing: cellClass)
        let cell = dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! T
        cell.configure(with: model)
        return cell
    }
    
    func dequeueTemplateCell<V: UIView>(
        forView _: V.Type,
        for indexPath: IndexPath,
        withModel model: V.Model
    ) -> TableCellTemplate<V> where V: ConfigurableView {
        let cell = dequeueCell(forCellClass: TableCellTemplate<V>.self, for: indexPath) as! TableCellTemplate<V>
        cell.view.configure(with: model)
        return cell
    }
    
    func dequeueSpacer(_ model: BaseTableSpacer.Model, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueTemplateCell(forView: BaseTableSpacer.self, for: indexPath, withModel: model)
    }
    
    func dequeueSeparator(_ props: BaseSeparator.Props, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueTemplateCell(forView: BaseSeparator.self, for: indexPath, withModel: props)
    }
}
