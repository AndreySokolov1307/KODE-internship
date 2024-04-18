//
//  CircleView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 18.04.2024.
//

import UI
import UIKit
final class CircleView: View {
    
    private let imageView = ImageView()
        .size(sideLength: 24)
    private let sideLenght: CGFloat
    
    override func setup() {
        super.setup()
        setupImageView()
        size(sideLength: sideLenght)
        cornerRadius(sideLenght / 2)
    }
    
    init(sideLenght: CGFloat) {
        self.sideLenght = sideLenght
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.pinCenter(toCenterOf: self)
    }
}

extension CircleView {
    @discardableResult
    func image(_ image: UIImage) -> Self {
        imageView.image(image)
        return self
    }
  
    @discardableResult
    func foregroundStyle(_ style: ForegroundStyle) -> Self {
        imageView.foregroundStyle(style)
        return self
    }
}
