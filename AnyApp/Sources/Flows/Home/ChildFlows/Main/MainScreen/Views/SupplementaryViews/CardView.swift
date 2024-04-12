//
//  CardView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import UI
import UIKit
final class CardView: View {
    
    private let imageView = ImageView(image: Asset.chevronDown.image)
    
    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(Palette.Content.primary)
    }
    
    private func body() -> UIView {
        imageView
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 28)
    }
}
