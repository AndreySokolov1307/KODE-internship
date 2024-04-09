import UIKit

public extension UITextField {

    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }

    @discardableResult
    func textColor(_ uiColor: UIColor?) -> Self {
        if let uiColor {
            self.textColor = uiColor
            defaultTextAttributes[NSAttributedString.Key.foregroundColor] = uiColor
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
        self.font = font
        defaultTextAttributes[NSAttributedString.Key.font] = font
        return self
    }

    @discardableResult
    func keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }

    @discardableResult
    func contentType(_ type: UITextContentType) -> Self {
        self.textContentType = type
        return self
    }

    @discardableResult
    func shouldBecomeFirstResponder() -> Self {
        self.becomeFirstResponder()
        return self
    }
}

// MARK: - `TextStyle` Support
public extension UITextField {

    @discardableResult
    func textStyle(_ textStyle: TextStyle?) -> Self {
        if let alignment = textStyle?.alignment {
            textAlignment(alignment)
        }
        font(textStyle?.font)
        return self
    }
}

