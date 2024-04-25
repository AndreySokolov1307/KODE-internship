//
//  LineView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 10.04.2024.
//

import UI
import UIKit

final class OtpLineView: View {
    
    var lineColor: UIColor? {
        didSet {
            line
                .backgroundColor(lineColor)
        }
    }
    
    private let line = View()
        .backgroundColor(Palette.Content.tertiary)
        .size(CGSize(width: 10, height: 2))
    
    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(.clear)
    }
    
    private func body() -> UIView {
        VStack {
            FlexibleGroupedSpacer()
            line
            FlexibleGroupedSpacer()
        }
    }
}
