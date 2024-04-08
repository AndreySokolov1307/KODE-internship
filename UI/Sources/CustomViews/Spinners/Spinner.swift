import UIKit

// swiftlint:disable:next final_class
open class Spinner: BaseView, StartStoppable {

    // MARK: - Properties

    private let spinnerProps: BaseSpinner.Props

    private lazy var spinner = BaseSpinner(props: spinnerProps)

    override public var intrinsicContentSize: CGSize { spinnerProps.size }

    public init(spinnerProps: BaseSpinner.Props) {
        self.spinnerProps = spinnerProps
        super.init(frame: .zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setup() {
        super.setup()
        embed(subview: spinner)
    }

    public func start(completion: (() -> Void)?) {
        spinner.start(completion: completion)
    }

    public func stop(completion: (() -> Void)?) {
        spinner.stop(completion: completion)
    }
}
