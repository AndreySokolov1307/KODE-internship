import UIKit
import AppIndependent

public final class ErrorView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .subtitle2)
        .textAlignment(.center)
    private let messageLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
        .textAlignment(.center)
        .multiline()
    private let imageView = ImageView()
    private var retryButton = ButtonPrimary()

    private var props: Props?

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack {
            FlexibleGroupedSpacer()
            imageView
                .image(props.image)
            Spacer(.px20)
            titleLabel
                .text(props.title)
            Spacer(.px2)
            messageLabel
                .text(props.message)
            FlexibleGroupedSpacer()
            retryButton
                .title(props.buttonTitle)
                .onTap { [weak self] in
                    self?.startLoading()
                    self?.props?.onTap?()
                }
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(vInsets: 32, hInsets: 16))
    }
    
    public func startLoading() {
        retryButton.startLoading()
    }
    
    public func stopLoading() {
        retryButton.stopLoading()
    }
}

// MARK: - Configurable

extension ErrorView: ConfigurableView {

    public typealias Model = Props

    public struct Props {
        public let title: String
        public let message: String
        public let image: UIImage

        public var buttonTitle: String
        public var onTap: VoidHandler?

        public init(title: String, message: String, image: UIImage, buttonTitle: String, onTap: VoidHandler? = nil) {
            self.title = title
            self.message = message
            self.image = image
            self.buttonTitle = buttonTitle
            self.onTap = onTap
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
