import UI
import UIKit

final class OptionView: BackgroundPrimary {
    
    // MARK: - Public Properties
    
    let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    let selectionImageView = ImageView(image: Asset.Images.radioOff.image, foregroundStyle: .textSecondary)
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    public func toSelectedState() {
        selectionImageView.foregroundStyle(.indicatorContentSuccess)
        selectionImageView.image(Asset.Images.radioOk.image)
    }
    
    public func toNormalState() {
        selectionImageView.foregroundStyle(.textSecondary)
        selectionImageView.image(Asset.Images.radioOff.image)
    }
    
    public func configure(with option: String) {
        titleLabel.text(option)
    }
    
    // MARK: - Private Methods
    
    private func body() -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            titleLabel
            FlexibleSpacer()
            selectionImageView
        }.height(56)
    }
}

