import UI
import UIKit
import AppIndependent

final class AboutAppView: BackgroundPrimary {
    
    // MARK: - Private Properties

    private let logo = ImageView(image: Asset.Images.logoBig.image, foregroundStyle: .contentAccentTertiary)
    private let versionLabel = Label(text: "Версия 0.0.1 beta", foregroundStyle: .contentAccentSecondary, fontStyle: .caption2)
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embedAtCenter(of: self)
    }
    
    // MARK: - Private Methods
    
    private func body() -> UIView {
        VStack(alignment: .center, spacing: 16) {
            logo
            versionLabel
        }
    }
}

