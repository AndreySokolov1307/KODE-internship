import UI
import UIKit

final class OtpItem: View {
    
    enum Size {
        case regular
    }
    
    // MARK: - Public Properties
    
    var label = Label(foregroundStyle: .textPrimary, fontStyle: .subtitle)
        .textAlignment(.center)
    
    var lineView = View()
        .height(2)
        .cornerRadius(1)
        .backgroundColor(Palette.Content.accentPrimary)
        .isHidden(true)
    
    // MARK: - Private Properties
    
    private let size = Size.regular
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(Palette.Content.primary)
            .cornerRadius(12)
            .masksToBounds(true)
    }
    
    func hideLineView() {
        lineView.isHidden = true
    }
    
    func showLineView() {
        lineView.isHidden = false
    }
    
    // MARK: - Private Methods
    
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: size.width, height: size.height)
    }
}

extension OtpItem.Size {
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
