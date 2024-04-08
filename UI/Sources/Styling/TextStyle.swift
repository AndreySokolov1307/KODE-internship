import UIKit

public protocol ProvidesFontName {

    var fontName: String { get }
}

public final class TextStyle {

    public let name: String

    public let size: CGFloat
    public var lineHeight: CGFloat?
    public var letterSpacing: CGFloat?

    // MARK: - Font
    private let _font: UIFont?
    public let customFontName: String?
    public lazy var font: UIFont? = {
        if let _font = _font {
            return _font
        }
        if let customFontName = customFontName {
            if customFontName == "system" {
                return UIFont.systemFont(ofSize: size, weight: weight ?? .regular)
            } else {
                let realFontFilename: String
                if let weight = weightRaw?.capitalized {
                    realFontFilename = "\(customFontName)-\(weight)"
                } else {
                    realFontFilename = customFontName
                }
                return UIFont(name: realFontFilename, size: size)
            }
        } else {
            return UIFont.systemFont(ofSize: size, weight: weight ?? .regular)
        }
    }()

    // MARK: - Weight
    private let _weight: UIFont.Weight?
    private let weightRaw: String?
    public lazy var weight: UIFont.Weight? = {
        if let _weight {
            return _weight
        }

        guard let weight = weightRaw else {
            return nil
        }

        if let weightFloat = CGFloat(string: weight) {
            if weightFloat > 1 {
                // HTML standard: from 100 to 900
                return UIFont.Weight.weight(fromHTML: weightFloat)
            } else {
                // iOS: UIFont.Weight range is from -1.0 to 1.0
                return UIFont.Weight(weightFloat)
            }
        } else {
            return UIFont.Weight.weight(fromHTMLName: weight)
        }
    }()

    // MARK: - Text Alignment
    private let _alignment: NSTextAlignment?
    private let alignmentRaw: String?
    public lazy var alignment: NSTextAlignment = {
        if let _alignment = _alignment {
            return _alignment
        }
        return NSTextAlignment(name: alignmentRaw)
    }()

    // MARK: - Underline Style
    private let _strikethroughStyle: NSUnderlineStyle?
    private let strikethroughStyleRaw: String?
    public lazy var strikethroughStyle: NSUnderlineStyle? = {
        _strikethroughStyle ?? strikethroughStyleRaw.flatMap(NSUnderlineStyle.init(string:))
    }()

    // MARK: - Strikethrough Style
    private let _underlineStyle: NSUnderlineStyle?
    private let underlineStyleRaw: String?
    public lazy var underlineStyle: NSUnderlineStyle? = {
        _underlineStyle ?? underlineStyleRaw.flatMap(NSUnderlineStyle.init(string:))
    }()

    // MARK: - Attributes Dictionary
    public lazy var stringAttributes: [NSAttributedString.Key: Any] = {
        var attributes: [NSAttributedString.Key: Any] = [:]

        // ParagraphStyle
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = alignment

        if let font = font {
            attributes[.font] = font

            // LineHeight
            if let lineHeight = lineHeight {
                let height = lineHeight - font.lineHeight
                paragraphStyle.lineSpacing = height
            }
        } else {
            assertionFailure()
        }

        if let letterSpacing = letterSpacing {
            attributes[NSAttributedString.Key.kern] = letterSpacing
        }

        if let strikethroughStyle = strikethroughStyle {
            attributes[.strikethroughStyle] = NSNumber(value: strikethroughStyle.rawValue)
        }

        if let underlineStyle = underlineStyle {
            attributes[.underlineStyle] = NSNumber(value: underlineStyle.rawValue)
        }

        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle

        return attributes
    }()

    public init?(
        name: String,
        size: Int,
        customFontName: String?,
        weight: String?,
        lineHeight: Double?,
        letterSpacing: Double?,
        alignment: String?,
        strikethroughStyle: String?,
        underlineStyle: String?
    ) {
        self.name = name

        self.size = CGFloat(size)
        self.lineHeight = CGFloat(double: lineHeight)
        self.letterSpacing = CGFloat(double: letterSpacing)

        _font = nil
        self.customFontName = customFontName

        _weight = nil
        weightRaw = weight

        _alignment = nil
        alignmentRaw = alignment

        _strikethroughStyle = nil
        strikethroughStyleRaw = strikethroughStyle

        _underlineStyle = nil
        underlineStyleRaw = underlineStyle
    }

    public init(
        name: String,
        font: UIFont,
        lineHeight: Double? = nil,
        letterSpacing: Double? = nil,
        alignment: String? = nil,
        strikethroughStyle: String? = nil,
        underlineStyle: String? = nil
    ) {
        self.name = name

        self.size = 0
        self.lineHeight = CGFloat(double: lineHeight)
        self.letterSpacing = CGFloat(double: letterSpacing)

        _font = font
        customFontName = nil

        _weight = nil
        weightRaw = nil

        _alignment = nil
        alignmentRaw = alignment

        _strikethroughStyle = nil
        strikethroughStyleRaw = strikethroughStyle

        _underlineStyle = nil
        underlineStyleRaw = underlineStyle
    }

    public init?(
        name: String,
        size: Int,
        customFontName: String? = nil,
        weight: UIFont.Weight? = nil,
        lineHeight: Double? = nil,
        letterSpacing: Double? = nil,
        alignment: NSTextAlignment? = nil,
        strikethroughStyle: NSUnderlineStyle? = nil,
        underlineStyle: NSUnderlineStyle? = nil
    ) {
        self.name = name

        self.size = CGFloat(size)
        self.lineHeight = CGFloat(double: lineHeight)
        self.letterSpacing = CGFloat(double: letterSpacing)

        _font = nil
        self.customFontName = customFontName

        _weight = weight
        weightRaw = nil

        _alignment = alignment
        alignmentRaw = nil

        _strikethroughStyle = strikethroughStyle
        strikethroughStyleRaw = nil

        _underlineStyle = underlineStyle
        underlineStyleRaw = nil
    }
}

extension Array where Element == TextStyle {

    func textStyle(named name: String?) -> TextStyle? {
        guard let name = name else { return nil }
        return self.first(where: { $0.name == name })
    }
}

extension CGFloat {

    init?(string: String?) {
        guard let string = string else { return nil }
        guard let double = Double(string) else { return nil }
        self = CGFloat(double)
    }

    init?(double: Double?) {
        guard let double = double else { return nil }
        self = CGFloat(double)
    }
}
