//
//  LineView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 10.04.2024.
//

import UI
import UIKit
// swiftlint:disable: trailing_whitespace
final class LineView: View {
    
    private let line = View()
        .backgroundColor(Asset.contentTertiary.color)
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
