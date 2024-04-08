import UIKit.UITextView
import AppIndependent

public extension UITextView {

    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }

    @discardableResult
    func linkTextAttributes(_ linkTextAttributes: [NSAttributedString.Key: Any]) -> Self {
        self.linkTextAttributes = linkTextAttributes
        return self
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
}

// MARK: - `TextStyle` Support
public extension UITextView {

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
        self.textAlignment = textStyle.alignment
        self.font = font
        return self
    }
}
