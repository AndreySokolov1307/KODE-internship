import UIKit
import AppIndependent

public final class LoadingView: View {

    // MARK: - Private Properties

    private let spinner = MediumSpinner(style: .contentAccentPrimary)
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        return UIVisualEffectView(effect: blur)
    }()

    // MARK: - Private methods
    
    override public func setup() {
        super.setup()
        backgroundColor(.clear)
        self.embed(subview: blurView, useSafeAreaGuide: false)
        self.embed(subview: body(), useSafeAreaGuide: false)
    }

    private func body() -> UIView {
        VStack {
            FlexibleGroupedSpacer()
            spinner
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
    }
    
    public func starLoading() {
        spinner.start()
    }
    
    public func stopLoading() {
        spinner.stop()
    }
}

