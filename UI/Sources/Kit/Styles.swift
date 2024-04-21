import UIKit

// Defines background color
public enum BackgroundStyle {
    case none

    case backgroundPrimary
    case backgroundSecondary
    
    case backgroundError
    case backgroundSuccess
}

// Defines textColor and tintColor
public enum ForegroundStyle {
    case none

    case contentPrimary
    case contentSecondary
    case contentTertiary
    case contentAccentPrimary
    case contentAccentSecondary
    case contentAccentTertiary

    case textPrimary
    case textSecondary
    case textTertiary

    case indicatorContentError
    case indicatorContentDone
    case indicatorContentSuccess

    case button
}

// Defines borderColor
public enum BorderStyle {
    case none
}

// Defines font
public enum FontStyle {
    case title
    case largeTitle
    case subtitle
    case subtitle2
    case body
    case body1
    case body2
    case body3
    case button
    case caption2
    case caption1
}

// Defines shadow properties
public enum ShadowStyle {
    case dropShadow1
    case card
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
        case .backgroundSecondary:
            return Palette.Surface.backgroundSecondary
        case .backgroundError:
            return Palette.Indicator.contentError
        case .backgroundSuccess:
            return Palette.Indicator.contentSuccess
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
        case .contentSecondary:
            return Palette.Content.secondary
        case .contentTertiary:
            return Palette.Content.tertiary
        case .contentAccentPrimary:
            return Palette.Content.accentPrimary
        case .contentAccentSecondary:
            return Palette.Content.accentSecondary
        case .contentAccentTertiary:
            return Palette.Content.accentTertirary
        case .textPrimary:
            return Palette.Text.primary
        case .textSecondary:
            return Palette.Text.secondary
        case .textTertiary:
            return Palette.Text.tertiary
        case .indicatorContentError:
            return Palette.Indicator.contentError
        case .indicatorContentDone:
            return Palette.Indicator.contentDone
        case .indicatorContentSuccess:
            return Palette.Indicator.contentSuccess
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
        case .largeTitle:
            return Typography.largetitle
        case .subtitle:
            return Typography.subtitle
        case .subtitle2:
            return Typography.subtitle2
        case .body:
            return Typography.body
        case .body1:
            return Typography.body1
        case .body2:
            return Typography.body2
        case .body3:
            return Typography.body3
        case .caption1:
            return Typography.caption1
        case .caption2:
            return Typography.caption2
        case .button:
            return Typography.button
        }
    }
}

public extension ShadowStyle {

    var shadowProps: ShadowProps {
        switch self {
        case .dropShadow1:
            return ShadowProps(radius: 16, color: Palette.Shadow.dropShadow1, offsetX: 0, offsetY: 8)
        case .card:
            return ShadowProps(radius: 22, color:  Palette.Shadow.card, offsetX: 0, offsetY: 7)
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
