import UIKit

public extension UICollectionView {

    func dequeueCell<T: UICollectionViewCell>(
        forCellClass cellClass: T.Type,
        for indexPath: IndexPath,
        configure: ((T) -> Void)? = nil
    ) -> UICollectionViewCell {

        let cellReuseIdentifier = String(describing: cellClass)
        if let cell = dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? T {
            configure?(cell)
            return cell
        } else {
            assertionFailure("Unable to dequeue collection cell")
            return UICollectionViewCell()
        }
    }

    func dequeueTemplateCell<V: UIView>(
        forView _: V.Type,
        for indexPath: IndexPath,
        configure: (((view: V, cell: CollectionCellTemplate<V>)) -> Void)? = nil
    ) -> CollectionCellTemplate<V> {

        let cell = dequeueCell(forCellClass: CollectionCellTemplate<V>.self, for: indexPath) as! CollectionCellTemplate<V>
        configure?((view: cell.view, cell: cell))
        return cell
    }

    func dequeueSupplementaryView<V: UICollectionReusableView>(
        forView: V.Type,
        ofKind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: ofKind,
            for: indexPath
        ) as? V else {
            fatalError("ReusableView \(V.self) did not register")
        }

        return view
    }

    func dequeueTemplateSupplementaryView<V: UIView>(
        forView: V.Type,
        ofKind kind: String,
        indexPath: IndexPath,
        configure: (((view: V, supplementaryView: CollectionSupplementaryTemplate<V>)) -> Void)? = nil
    ) -> CollectionSupplementaryTemplate<V> {

        let supplementaryView = dequeueSupplementaryView(
            forView: CollectionSupplementaryTemplate<V>.self,
            ofKind: kind,
            indexPath: indexPath
        ) as! CollectionSupplementaryTemplate<V>
        configure?((view: supplementaryView.view, supplementaryView: supplementaryView))
        return supplementaryView
    }
}

extension UICollectionView {

    func dequeueCell<T: UICollectionViewCell>(
        forCellClass cellClass: T.Type,
        for indexPath: IndexPath,
        withModel model: T.Model
    ) -> UICollectionViewCell where T: ConfigurableView {

        let cellReuseIdentifier = String(describing: cellClass)
        let cell = dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! T
        cell.configure(with: model)
        return cell
    }

    func dequeueTemplateCell<V: UIView>(
        forView _: V.Type,
        for indexPath: IndexPath,
        withModel model: V.Model
    ) -> CollectionCellTemplate<V> where V: ConfigurableView {

        let cell = dequeueCell(forCellClass: CollectionCellTemplate<V>.self, for: indexPath) as! CollectionCellTemplate<V>
        cell.view.configure(with: model)
        return cell
    }

    func dequeueSpacer(
        _ space: BaseSpacer.Model, for
        indexPath: IndexPath
    ) -> UICollectionViewCell {

        return dequeueTemplateCell(forView: BaseSpacer.self, for: indexPath, withModel: space)
    }

    func dequeueSeparator(
        _ model: BaseSeparator.Model,
        for indexPath: IndexPath
    ) -> UICollectionViewCell {

        return dequeueTemplateCell(forView: BaseSeparator.self, for: indexPath, withModel: model)
    }
}
