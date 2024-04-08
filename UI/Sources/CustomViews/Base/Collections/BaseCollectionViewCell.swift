import UIKit.UICollectionView

// swiftlint:disable:next final_class
open class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateAppearance()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        updateAppearance()
    }

    // MARK: - Methods to Implement

    open func setup() { }

    open func updateAppearance() { }
}
