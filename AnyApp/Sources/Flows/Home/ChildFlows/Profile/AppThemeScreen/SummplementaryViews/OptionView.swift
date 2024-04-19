//
//  OptionView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//

import UI
import UIKit

final class OptionView: BackgroundPrimary {
    
    let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body2)
    let selectionImageView = ImageView(image: Asset.Images.radioOff.image, foregroundStyle: .textSecondary)
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    private func body() -> UIView {
        HStack(alignment: .center, distribution: .fill) {
            titleLabel
            FlexibleSpacer()
            selectionImageView
        }.height(56)
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
}

