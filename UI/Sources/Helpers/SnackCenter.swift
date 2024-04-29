import UIKit
import SnapKit
import AppIndependent

public final class SnackCenter {

    public static var shared = SnackCenter()

    // MARK: - Public Properties

    public var snacksQueue: [SnackView] = []

    // MARK: - Private Properties

    private var keyboardHeight: CGFloat?

    // MARK: - Public Methods

    public func showSnack(withProps props: SnackView.Props) {
        assert(Thread.isMainThread)
        let scene = UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundActive }
        ?? UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundInactive }

        guard
            let windowScene = scene as? UIWindowScene,
            let window = windowScene.windows.first(where: { $0.isKeyWindow })
        else {
            Logger().warn("Could not find a foreground scene to present the snack on")
            return
        }

        guard !snacksQueue.contains(where: { $0.props == props }) else {
            Logger().warn("The snack is already in the queue")
            return
        }

        let snack = SnackView(props: props)

        snack.onDismiss = { [weak self] in
            guard let self, !self.snacksQueue.isEmpty else { return }

            self.snacksQueue.remove(at: 0)

            if let snack = self.snacksQueue.first {
                self.place(snack: snack, onWindow: window)
            }
        }

        snacksQueue.append(snack)

        if snacksQueue.count == 1 {
            place(snack: snack, onWindow: window)
        }
    }

    private func place(snack: SnackView, onWindow window: UIView) {
        window.addSubview(snack)
        snack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
            $0.top.equalTo(window.safeAreaLayoutGuide.snp.top)
        }
    }
}

extension SnackCenter {
    public func showInDevelopmentSnack() {
        showSnack(withProps: .init(message: "В разработке", style: .basic))
    }
}
