import UIKit

// MARK: - Attributes getters

fileprivate extension UITextField {

    private func currentTextAttributes() -> [NSAttributedString.Key : Any]? {
        return attributedText?.attributes
    }

    private func currentAttributedFont() -> UIFont? {
        return attributedText?.value(ofAttribute: .font) as? UIFont
    }

    private func currentAttributedTextColor() -> UIColor? {
        return attributedText?.value(ofAttribute: .foregroundColor) as? UIColor
    }
}

// MARK: - Placeholder attributes getters

fileprivate extension UITextField {

    private func currentPlaceholderAttributes() -> [NSAttributedString.Key : Any]? {
        return attributedPlaceholder?.attributes
    }

    private func currentPlaceholderFont() -> UIFont? {
        return attributedPlaceholder?.value(ofAttribute: .font) as? UIFont
    }

    private func currentPlaceholderTextColor() -> UIColor? {
        return attributedPlaceholder?.value(ofAttribute: .foregroundColor) as? UIColor
    }
}
