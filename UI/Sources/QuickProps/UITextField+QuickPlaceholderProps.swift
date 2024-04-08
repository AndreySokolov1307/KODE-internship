import UIKit

public extension UITextField {

    @discardableResult
    func placeholder(_ text: String?) -> Self {
        self.placeholder = text
        return self
    }

    /// Changes placeholder text color if text exists.
    /// Have no effect on future text updates, you should call this method again
    @discardableResult
    func placeholderColor(_ uiColor: UIColor?) -> Self {
        attributedPlaceholder = attributedPlaceholder?.with(.foregroundColor, value: uiColor)
        return self
    }

    /// Changes placeholder font if text exists.
    /// Have no effect on future text updates, you should call this method again
    @discardableResult
    func placeholderFont(_ font: UIFont?) -> Self {
        attributedPlaceholder = attributedPlaceholder?.with(.font, value: font)
        return self
    }
}

// MARK: - `TextStyle` Support
public extension UITextField {

    @discardableResult
    func placeholderTextStyle(_ textStyle: TextStyle?) -> Self {
        placeholderFont(textStyle?.font)
    }
}
