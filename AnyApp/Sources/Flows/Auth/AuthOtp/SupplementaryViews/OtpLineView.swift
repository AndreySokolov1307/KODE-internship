import UI
import UIKit

final class OtpLineView: View {
    
    // MARK: - Public Properties
    
    var lineColor: UIColor? {
        didSet {
            line
                .backgroundColor(lineColor)
        }
    }
    
    // MARK: - Private Properties
    
    private let line = View()
        .backgroundColor(Palette.Content.tertiary)
        .size(CGSize(width: 10, height: 2))
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(.clear)
    }
    
    // MARK: - Private Methods
    
    private func body() -> UIView {
        VStack {
            FlexibleGroupedSpacer()
            line
            FlexibleGroupedSpacer()
        }
    }
}
