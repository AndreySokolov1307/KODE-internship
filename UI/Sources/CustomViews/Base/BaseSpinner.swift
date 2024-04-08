import UIKit
import Combine

// swiftlint:disable:next final_class
open class BaseSpinner: BaseView, StartStoppable {

    public struct Props {

        public let size: CGSize
        public let elementsCount: Int
        public let elementSize: CGSize
        public let elementsAnimationDuration: CFTimeInterval
        public let elementColor: AnyPublisher<CGColor, Never>

        public init(
            size: CGSize,
            elementsCount: Int,
            elementSize: CGSize,
            elementsAnimationDuration: CFTimeInterval,
            elementColor: AnyPublisher<CGColor, Never>
        ) {
            self.size = size
            self.elementsCount = elementsCount
            self.elementSize = elementSize
            self.elementsAnimationDuration = elementsAnimationDuration
            self.elementColor = elementColor
        }
    }

    // MARK: - Properties

    private static let elementsAnimationKey = "spinner_animation"
    private var props: Props?
    private var colorSubscription: Cancellable?

    private let replicatorLayer = CAReplicatorLayer()
    private let shapeLayer = CAShapeLayer()

    /// Animation initialization was delayed because it happened before view receives it's frame/frame. Should retry when layout completed
    private var shouldStartAnimationLater = false

    public required init(props: Props? = nil) {
        super.init(frame: .zero)
        self.props = props
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func setup() {
        super.setup()
        layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(shapeLayer)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        guard let props else {
            return
        }

        shapeLayer.path = UIBezierPath(
            roundedRect: CGRect(
                origin: .init(
                    x: bounds.width / 2 - props.elementSize.width / 2,
                    y: 0
                ),
                size: props.elementSize
            ),
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: 1, height: 1)
        ).cgPath
        if colorSubscription == nil {
            colorSubscription = props.elementColor.sink(receiveValue: { [weak shapeLayer] cgColor in
                shapeLayer?.fillColor = cgColor
            })
        }
        replicatorLayer.frame = bounds

        if shouldStartAnimationLater && bounds != .zero {
            start()
        }
    }

    open func start(completion: (() -> Void)?) {
        guard let props else {
            return
        }

        guard bounds != .zero else {
            shouldStartAnimationLater = true
            return
        }

        shapeLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = props.elementsAnimationDuration
        opacityAnimation.repeatCount = Float.infinity
        shapeLayer.add(opacityAnimation, forKey: Self.elementsAnimationKey)

        replicatorLayer.instanceCount = props.elementsCount
        replicatorLayer.instanceDelay = props.elementsAnimationDuration / CFTimeInterval(props.elementsCount)

        let angle = CGFloat(2.0 * Double.pi) / CGFloat(props.elementsCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        completion?()
    }

    open func stop(completion: (() -> Void)?) {
        guard shapeLayer.animation(forKey: Self.elementsAnimationKey) != nil else {
            return
        }
        shapeLayer.removeAnimation(forKey: Self.elementsAnimationKey)

        completion?()
    }

    deinit {
        stop()
    }
}
