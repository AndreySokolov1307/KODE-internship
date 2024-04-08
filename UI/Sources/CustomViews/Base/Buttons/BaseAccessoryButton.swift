import UIKit

// swiftlint:disable:next final_class
open class BaseAccessoryButton: BaseButton {

    public enum Accessory {

        public enum Position: Equatable {
            case beforeTitle(padding: CGFloat)
            case afterTitle(padding: CGFloat)
            case rightEdge
            case center
        }

        case none
        case subview(UIView, Position)
        case image(UIImage, Position) // TODO: preferredSize
    }

    // MARK: - Properties

    public private(set) var accessoryView: UIView?

    // MARK: - Public Methods

    @discardableResult
    public func accessory(_ accessory: Accessory, completion: (() -> Void)? = nil) -> Self {
        updateAccessory(with: accessory, completion: completion)
        return self
    }

    private func updateAccessory(with accessory: Accessory, completion: (() -> Void)?) {
        titleEdgeInsets.left = 0

        switch accessory {
        case .none:
            removeAccessory()
            completion?()
            titleLabel?.fadeIn()

        case let .image(image, position):
            removeAccessory { [weak self] in
                let newAccessoryView = BaseImageView(image: image)
                self?.embed(
                    accessoryView: newAccessoryView,
                    position: position
//                    preferredSize: CGSize(width: 24, height: 24)
                )
                completion?()
            }

        case let .subview(subview, position):
            removeAccessory { [weak self] in
                self?.embed(
                    accessoryView: subview,
                    position: position
                )
                completion?()
            }
        }
    }

    private func removeAccessory(completion: (() -> Void)? = nil) {
        if let startStoppableView = accessoryView as? StartStoppable {
            startStoppableView.stop { [weak accessoryView] in
                accessoryView?.removeFromSuperview()
                completion?()
            }
        } else {
            accessoryView?.removeFromSuperview()
            completion?()
        }
    }

    private func embed(
        accessoryView: UIView,
        position: Accessory.Position,
        preferredSize: CGSize? = nil
    ) {
        self.accessoryView = accessoryView

        if !accessoryView.isDescendant(of: self) {
            addSubview(accessoryView.noMaskTranslation())
        }

        if let preferredSize {
            accessoryView.size(preferredSize)
        }

        switch position {
        case .beforeTitle(let padding):
            accessoryView.pinCenterY(toCenterYOf: self)
            if let titleLabel {
                accessoryView.pinTrailing(toLeadingOf: titleLabel, inset: padding)
                titleEdgeInsets.left = accessoryView.frame.width + padding
            }
        case .afterTitle(let padding):
            accessoryView.pinCenterY(toCenterYOf: self)
            if let titleLabel {
                accessoryView.pinLeading(toTrailingOf: titleLabel, inset: -padding)
                titleEdgeInsets.left = -accessoryView.frame.width - padding
            }
        case .rightEdge:
            accessoryView.pinCenterY(toCenterYOf: self)
            accessoryView.pinTrailing(toTrailingOf: self, inset: 16)
        case .center:
            accessoryView.pinCenter(toCenterOf: self)
        }
    }
}
