import UIKit
import AppIndependent

// swiftlint:disable:next final_class
open class ScrollView: UIScrollView {

    // MARK: - Properties

    public let axis: NSLayoutConstraint.Axis

    // MARK: - Init

    public init(
        axis: NSLayoutConstraint.Axis = .vertical,
        padding: CGFloat = 0,
        @ScrollViewBuilder content: () -> UIView
    ) {
        self.axis = axis
        super.init(frame: .zero)

        let subview = content()
        if let stack = subview as? UIStackView, stack.axis != axis {
            Logger().warn("ScrollView axis is not equal to subview")
        }

        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        addConstraints([
            subview.leadingAnchor.constraint(
                equalTo: contentLayoutGuide.leadingAnchor,
                constant: axis == .vertical ? padding : 0
            ),
            subview.trailingAnchor.constraint(
                equalTo: contentLayoutGuide.trailingAnchor,
                constant: axis == .vertical ? -padding : 0
            ),
            subview.topAnchor.constraint(
                equalTo: contentLayoutGuide.topAnchor,
                constant: axis == .horizontal ? padding : 0),
            subview.bottomAnchor.constraint(
                equalTo: contentLayoutGuide.bottomAnchor,
                constant: axis == .horizontal ? -padding : 0
            ),
            axis == .horizontal
            ? subview.heightAnchor.constraint(equalTo: heightAnchor, constant: -2 * padding)
            : subview.widthAnchor.constraint(equalTo: widthAnchor, constant: -2 * padding)
        ])

        setup()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods to Implement

    open func setup() { }

    // MARK: - Public Methods

    @discardableResult public func keyboardDismissMode(_ dismissMode: KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = dismissMode
        return self
    }

    /// Scroll to first view, who's responder is current window's firstResponder
    public func scrollToResponder<T: BaseResponderContainerView>(
        among possibleResponders: [T],
        additionalInsetHeight: CGFloat
    ) {
        if let firstResponder = possibleResponders.first(where: { $0.responder.isFirstResponder }) {
            let responderPoint = convert(firstResponder.frame.origin, to: self)
            let scrollViewHeight = frame.height
            let responderYOffset = responderPoint.y
            let responderHeight = firstResponder.bounds.height
            let missingHeight = scrollViewHeight - (responderYOffset + responderHeight + additionalInsetHeight)

            setContentOffset(
                missingHeight < 0 ? .init(x: 0, y: -missingHeight) : .zero,
                animated: true
            )
        } else {
            setContentOffset(.zero, animated: true)
        }
    }
}

public protocol BaseResponderContainerView: UIView {
    var responder: UIResponder { get set }
}
