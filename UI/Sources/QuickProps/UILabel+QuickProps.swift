import UIKit.UILabel
import AppIndependent

public extension UILabel {

    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func textColor(_ uiColor: UIColor?) -> Self {
        if let uiColor {
            self.textColor = uiColor
        }
        return self
    }

    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func font(_ font: UIFont?) -> Self {
        if let font {
            self.font = font
        }
        return self
    }

    @discardableResult
    func linesCount(_ count: Int) -> Self {
        self.numberOfLines = count
        return self
    }

    @discardableResult
    func multiline() -> Self {
        self.numberOfLines = 0
        return self
    }
}

// MARK: - `TextStyle` Support
public extension UILabel {

    @discardableResult
    func textStyle(_ textStyle: TextStyle?) -> Self {
        guard let textStyle else {
            Logger().warn("Failed to apply TextStyle to '\(self)': 'textStyle' is 'nil'")
            return self
        }
        guard let font = textStyle.font else {
            Logger().warn("Failed to define UIFont for textStyle \(textStyle.name)")
            return self
        }
        self.font = font
        return self
    }
}
