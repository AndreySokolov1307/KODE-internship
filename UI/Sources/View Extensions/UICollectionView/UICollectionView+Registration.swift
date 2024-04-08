import UIKit

public extension UICollectionView {

    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let cellReuseIdentifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: cellReuseIdentifier)
    }

    func registerTemplateCell<V: UIView>(forView _: V.Type) {
        register(cellClass: CollectionCellTemplate<V>.self)
    }

    func register<T: UICollectionReusableView>(
        supplementaryViewClass: T.Type,
        reuseId: String
    ) {
        register(
            supplementaryViewClass,
            forSupplementaryViewOfKind: reuseId,
            withReuseIdentifier: reuseId
        )
    }

    func registerTemplateSupplementaryView<V: UIView>(
        forView _: V.Type,
        reuseId: String
    ) {
        register(
            supplementaryViewClass: CollectionSupplementaryTemplate<V>.self,
            reuseId: reuseId
        )
    }
}
