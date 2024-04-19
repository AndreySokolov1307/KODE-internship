//
//  AboutAppView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 19.04.2024.
//

import UI
import UIKit
import AppIndependent

final class AboutAppView: BackgroundPrimary {

    private let logo = ImageView(image: Asset.Images.logoBig.image, foregroundStyle: .contentAccentTertiary)
    private let versionLabel = Label(text: "Версия 0.0.1 beta", foregroundStyle: .contentAccentSecondary, fontStyle: .caption2)
    
    override func setup() {
        super.setup()
        body().embedAtCenter(of: self)
    }
    private func body() -> UIView {
        VStack(alignment: .center, spacing: 16) {
            logo
            versionLabel
        }
    }
}

