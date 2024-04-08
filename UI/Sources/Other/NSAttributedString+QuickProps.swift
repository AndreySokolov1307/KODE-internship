import UIKit

public extension NSAttributedString {

    var attributes: [NSAttributedString.Key : Any]? {
        attributes(at: 0, effectiveRange: nil)
    }

    func value(ofAttribute key: NSAttributedString.Key) -> Any? {
        attributes?[key]
    }

    /// Make copy of attributed string with updated value with given key
    func with(_ attributeKey: NSAttributedString.Key, value: Any?) -> NSAttributedString {
        var newAttributes = attributes ?? [:]
        newAttributes[attributeKey] = value
        return NSAttributedString(
            string: string,
            attributes: newAttributes
        )
    }

    /// Make copy of attributed string with updated value with given key in range (if range is valid). If value is nil, tries to remove this attribute in range
    func with(
        _ attributeKey: NSAttributedString.Key,
        value: Any?,
        atRange range: ClosedRange<Int>
    ) -> NSAttributedString {
        guard
            !range.isEmpty,
            string.count > range.upperBound
        else {
            return self
        }
        let mutableCopy = NSMutableAttributedString(attributedString: self)
        let nsRange = NSRange(range)
        if let value {
            mutableCopy.addAttribute(attributeKey, value: value, range: nsRange)
        } else {
            mutableCopy.removeAttribute(attributeKey, range: nsRange)
        }
        return mutableCopy
    }
}

public extension NSAttributedString {

    convenience init?(htmlString: String, defaultAttributes: [NSAttributedString.Key: Any]? = nil) {
        guard let data = htmlString.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue,
            .defaultAttributes: defaultAttributes ?? [:]
        ]

        try? self.init(data: data, options: options, documentAttributes: nil)
    }
}

public extension NSAttributedString {

    var range: NSRange {
        NSRange(location: 0, length: length)
    }

    func color(_ color: UIColor?) -> NSMutableAttributedString {
        return attribute(.foregroundColor, value: color)
    }

    func font(_ font: UIFont?) -> NSMutableAttributedString {
        return attribute(.font, value: font)
    }

    func paragraph(_ style: NSParagraphStyle?) -> NSMutableAttributedString {
        return attribute(.paragraphStyle, value: style)
    }

    func alignment(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alignment
        return attribute(.paragraphStyle, value: paragraph)
    }

    func background(_ color: UIColor?) -> NSMutableAttributedString {
        return attribute(.backgroundColor, value: color)
    }

    func ligature(_ value: Int = 1) -> NSMutableAttributedString {
        return attribute(.backgroundColor, value: NSNumber(value: value))
    }

    func stroke(_ color: UIColor?, width: Double = 0) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.strokeWidth: NSNumber(value: Float(width))]
        if let color = color {
            attrs[.strokeColor] = color
        }
        return attributes(attrs)
    }

    func kerning(_ kerning: Double = 0) -> NSAttributedString {
        return attribute(.kern, value: NSNumber(value: Float(kerning)))
    }

    func shadow(color: UIColor?, offset: CGSize = .zero, blur: CGFloat) -> NSMutableAttributedString {
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blur
        return attribute(.shadow, value: shadow)
    }

    func bold(in range: NSRange? = nil) -> NSMutableAttributedString {
        guard let font = attribute(.font, at: 0, longestEffectiveRange: nil, in: self.range) as? UIFont,
            let descriptor = font.fontDescriptor.withSymbolicTraits(.traitBold) else {
                return NSMutableAttributedString(attributedString: self)
        }
        return attribute(.font, value: UIFont(descriptor: descriptor, size: font.pointSize), range: range)
    }

    func italic() -> NSMutableAttributedString {
        guard let font = attribute(.font, at: 0, longestEffectiveRange: nil, in: range) as? UIFont,
            let descriptor = font.fontDescriptor.withSymbolicTraits(.traitItalic) else {
                return NSMutableAttributedString(attributedString: self)
        }
        return attribute(.font, value: UIFont(descriptor: descriptor, size: font.pointSize))
    }

    func strikethrough(_ style: NSUnderlineStyle, color: UIColor? = nil) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.strikethroughStyle: NSNumber(value: style.rawValue)]
        if let color = color {
            attrs[.strikethroughColor] = color
        }
        return attributes(attrs)
    }

    func underline(_ style: NSUnderlineStyle, color: UIColor? = nil) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.underlineStyle: NSNumber(value: style.rawValue)]
        if let color = color {
            attrs[.underlineColor] = color
        }
        return attributes(attrs)
    }

    func baselineOffset(_ offset: Double?) -> NSMutableAttributedString {
        var number: NSNumber?
        if let offset = offset {
            number = NSNumber(value: Float(offset))
        }
        return attribute(.baselineOffset, value: number)
    }

    private func attribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange? = nil) -> NSMutableAttributedString {
        guard let value = value else { return NSMutableAttributedString(attributedString: self) }
        let attributed = NSMutableAttributedString(attributedString: self)
        attributed.addAttribute(key, value: value, range: range)
        return attributed
    }

    private func attributes(_ attrs: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributed = NSMutableAttributedString(attributedString: self)
        attributed.addAttributes(attrs)
        return attributed
    }
}

fileprivate extension NSMutableAttributedString {

    func addAttributes(_ attrs: [NSAttributedString.Key: Any]) {
        addAttributes(attrs, range: range)
    }

    func addAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange? = nil) {
        if let range = range {
            addAttribute(name, value: value, range: range)
        } else {
            addAttribute(name, value: value)
        }
    }

    func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        addAttribute(key, value: value, range: range)
    }
}
