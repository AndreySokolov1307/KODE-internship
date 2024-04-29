import UI
import UIKit
final class CircleView: View {
    
    // MARK: - Private Properties
    
    private let imageView = ImageView()
        .size(sideLength: 24)
    private let sideLenght: CGFloat
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        setupImageView()
        size(sideLength: sideLenght)
        cornerRadius(sideLenght / 2)
    }
    
    // MARK: - CirleView
    
    init(sideLenght: CGFloat) {
        self.sideLenght = sideLenght
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
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
