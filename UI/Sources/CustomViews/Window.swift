import UIKit
import Combine

public final class Window: UIWindow {

    public var cancellables = Set<AnyCancellable>()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        AppearanceManager.shared.updateThemeIfNeeded()
    }

    override public func makeKeyAndVisible() {
        super.makeKeyAndVisible()
        AppearanceManager.shared.updateThemeIfNeeded()
    }

    private func setupBindings() {
        AppearanceManager.shared.$themeRaw
            .receive(on: RunLoop.main)
            .sink { [weak self] theme in
                let style: UIUserInterfaceStyle
                switch theme {
                case .light:
                    style = .light
                case .dark:
                    style = .dark
                case .auto:
                    style = .unspecified
                }

                self?.overrideUserInterfaceStyle = style
            }
            .store(in: &cancellables)
    }
}
