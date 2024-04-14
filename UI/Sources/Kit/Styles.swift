import UIKit

// Defines background color
public enum BackgroundStyle {
    case none

    case backgroundPrimary
}

// Defines textColor and tintColor
public enum ForegroundStyle {
    case none

    case contentPrimary
    case textPrimary
    case contentAccentPrimary
    case textSecondary
    case textTertiary

    case button
}

// Defines borderColor
public enum BorderStyle {
    case none
}

// Defines font
public enum FontStyle {
    case title
    case title2
    case subtitle2
    case button
    case caption2
    case caption1
}

// Defines shadow properties
public enum ShadowStyle {
    case dropShadow1
}

// Defines gradient properties
public enum GradientStyle {
    case none
    case gradient1
}

public extension BackgroundStyle {

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case .backgroundPrimary:
            return Palette.Surface.backgroundPrimary
        }
    }
}

public extension ForegroundStyle {

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case .contentPrimary:
            return Palette.Content.primary
        case .textPrimary:
            return Palette.Text.primary
        case .textSecondary:
            return Palette.Text.secondary
        case .textTertiary:
            return Palette.Text.tertiary
        case .contentAccentPrimary:
            return Palette.Content.contentAccentPrimary
        case .button:
            return Palette.Button.buttonText
        }
    }
}

public extension BorderStyle {

    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        }
    }
}

public extension FontStyle {

    var textStyle: TextStyle? {
        switch self {
        case .title:
            return Typography.title
        case .button:
            return Typography.button
        case .caption2:
            return Typography.caption2
        case .caption1:
            return Typography.caption1
        case .title2:
            return Typography.title2
        case .subtitle2:
            return Typography.subtitle2
        }
    }
}

public extension ShadowStyle {

    var shadowProps: ShadowProps {
        switch self {
        case .dropShadow1:
            return ShadowProps(radius: 16, color: Palette.Shadow.dropShadow1, offsetX: 0, offsetY: 8)
        }
    }
}

public extension GradientStyle {

    var gradientProps: GradientProps? {
        switch self {
        case .none:
            return nil
        case .gradient1:
            return Palette.Gradient.gradient1
        }
    }
}
