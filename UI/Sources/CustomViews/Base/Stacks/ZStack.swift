import UIKit

public final class ZStack: BaseView {

    public enum PositioningMode {
        case center
        case fill
    }

    // MARK: - Properties

    private var arrangedSubviews: [UIView] {
        subviews.filter { $0.tag == 1 }
    }

    private let positioningMode: PositioningMode

    // MARK: - Init

    public init(
        positioningMode: PositioningMode = .center,
        margins: NSDirectionalEdgeInsets = .zero,
        @StackViewBuilder content: () -> [UIView]
    ) {
        self.positioningMode = positioningMode
        super.init(frame: .zero)
        self.directionalLayoutMargins = margins

        content().forEach {
            addArrangedSubview($0)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override public func setup() {
        super.setup()
        backgroundColor = .clear
    }

    func addArrangedSubview(_ subview: UIView) {
        subview.tag = 1
        subview.willMove(toSuperview: self)
        addSubview(subview.noMaskTranslation())
        subview.didMoveToSuperview()

        switch positioningMode {
        case .center:
            subview.pinCenter(toCenterOf: self)
            addConstraints([
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leadingAnchor),
                subview.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),
                subview.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
                subview.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor)
            ])

        case .fill:
            subview.pinEdges(inside: self, useMarginsGuide: true)
        }
    }
}
