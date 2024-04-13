//
//  CardView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UI
import UIKit
final class CardView: View {
    
    private let cardLabel = Label()
        .font(UIFont.systemFont(ofSize: 10, weight: .regular))
    private let paymentSystemImageView = ImageView()
    private let imageView = ImageView(image: Asset.bankCard.image)
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    private func body() -> UIView {
        imageView.embed(subview: foregroundBody())
    }
    
    private func foregroundBody() -> UIView {
        VStack(alignment: .trailing, distribution: .fill,spacing: 1) {
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
    
    func image(_ image: UIImage) -> Self {
        paymentSystemImageView.image(image)
        return self
    }
    
    func textColor(_ color: UIColor) -> Self {
        cardLabel.textColor(color)
        return self
    }
}
