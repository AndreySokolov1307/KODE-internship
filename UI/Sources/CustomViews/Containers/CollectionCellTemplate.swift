import UIKit

// swiftlint:disable:next final_class
open class CollectionCellTemplate<View: UIView>: UICollectionViewCell {

    public var view: View!

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
        setup()
    }

    // MARK: - Public Methods

    open func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    open func layout() {
        makeView()
        contentView.addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = contentView.bounds
    }

    open func makeView() {
        view = View()
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        (view as? PreparableForReuse)?.prepareForReuse()
    }
}
