import UIKit
import AppIndependent

public extension UIButton {

    @discardableResult
    func title(_ title: String?) -> Self {
        setTitle(title, for: .normal)
        return self
    }

    @discardableResult
    func titleColor(_ uiColor: UIColor?, for controlState: UIControl.State = .normal) -> Self {
        if let uiColor {
            setTitleColor(uiColor, for: controlState)
        }
        return self
    }
}

// MARK: - `TextStyle` Support
public extension UIButton {

    @discardableResult
    func textStyle(_ textStyle: TextStyle?) -> Self {
        guard let titleLabel else {
            return self
        }
        guard let textStyle else {
            Logger().warn("Failed to apply TextStyle to '\(self)': 'textStyle' is 'nil'")
            return self
        }
        guard let font = textStyle.font else {
            Logger().warn("Failed to define UIFont for textStyle \(textStyle.name)")
            return self
        }

        titleLabel.font = font
        return self
    }
}
