//
//  OTPLabel.swift
//  AnyApp
//
//  Created by Андрей Соколов on 10.04.2024.
//

import UI
import UIKit

final class OTPLabel: View {
    enum Size {
        case regular
    }
    
    private let size = Size.regular
    var label = Label(foregroundStyle: .textPrimary, fontStyle: .subtitle)
        .textAlignment(.center)
    
    var lineView = View()
        .height(2)
        .cornerRadius(1)
        .backgroundColor(Palette.Content.accentPrimary)
        .isHidden(true)
    
    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(Palette.Content.primary)
            .cornerRadius(12)
            .masksToBounds(true)
    }
    
    private func body() -> UIView {
        label.embed(subview: lineViewBody())
    }
    
    private func lineViewBody() -> UIView {
        VStack {
            FlexibleGroupedSpacer()
            lineView
                .cornerRadius(2)
            Spacer(.px8)
        }
        .layoutMargins(.make(hInsets: 8))
    }
    
    func hideLineView() {
        lineView.isHidden = true
    }
    
    func showLineView() {
        lineView.isHidden = false
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: size.width, height: size.height)
    }
}

extension OTPLabel.Size {
    var height: CGFloat {
        switch self {
        case .regular:
            return 48
        }
    }
    
    var width: CGFloat {
        switch self {
        case .regular:
            return 40
        }
    }
}
