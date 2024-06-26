import UI
import UIKit

final class CardView: View {
    
    // MARK: - Private Properties
    
    private let cardLabel = Label()
        .font(UIFont.systemFont(ofSize: 10, weight: .regular))
    private let paymentSystemImageView = ImageView()
    private let imageView = ImageView(image: Asset.Images.bankCard.image)
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    // MARK: - Private Methods
    
    private func body() -> UIView {
        imageView.embed(subview: foregroundBody())
    }
    
    private func foregroundBody() -> UIView {
        VStack(alignment: .trailing, distribution: .fill, spacing: 1) {
            cardLabel
            paymentSystemImageView
        }
        .layoutMargins(.make(vInsets: 2, hInsets: 4))
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 28)
    }
}

extension CardView {
    @discardableResult
    func text(_ text: String) -> Self {
        cardLabel.text(text)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage) -> Self {
        paymentSystemImageView.image(image)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        cardLabel.textColor(color)
        return self
    }
}
