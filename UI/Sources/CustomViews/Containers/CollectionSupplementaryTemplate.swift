import UIKit

// swiftlint:disable:next final_class
open class CollectionSupplementaryTemplate<View: UIView>: UICollectionReusableView {

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
    }

    open func layout() {
        makeView()
        addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
    }

    open func makeView() {
        view = View()
    }
}
