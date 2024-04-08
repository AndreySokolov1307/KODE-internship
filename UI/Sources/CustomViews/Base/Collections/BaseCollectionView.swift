import UIKit.UICollectionView

// swiftlint:disable:next final_class
open class BaseCollectionView: UICollectionView {

    // MARK: - Init

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Methods to Implement

    open func setup() { }
}
