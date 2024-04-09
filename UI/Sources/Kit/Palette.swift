import UIKit
import SkeletonView

private var currentTheme: Theme { AppearanceManager.shared.theme }

// swiftlint:disable type_body_length
public enum Palette {

    // MARK: - Surface

    public enum Surface {

        public static var backgroundPrimary: UIColor { backgroundPrimary(forTheme: currentTheme) }
        public static func backgroundPrimary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x312C39)
            case .light:
                return UIColor(hex: 0xFFFFFF)
            }
        }
    }

    // MARK: - Content

    public enum Content {

        public static var primary: UIColor { primary(forTheme: currentTheme) }
        public static func primary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x3B3542)
            case .light:
                return UIColor(hex: 0xF3F3F3)
            }
        }

        public static var accentSecondary: UIColor { accentSecondary(forTheme: currentTheme) }
        public static func accentSecondary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0xF678BA)
            case .light:
                return UIColor(hex: 0xFC5DA8)
            }
        }
    
        public static var contentAccentPrimary: UIColor { contentAccentPrimary(forTheme: currentTheme) }
        public static func contentAccentPrimary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x6C78E6)
            case .light:
                return UIColor(hex: 0x515FE1)
            }
        }
    }

    // MARK: - Text

    public enum Text {

        public static var primary: UIColor { primary(forTheme: currentTheme) }
        public static func primary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0xFFFFFF)
            case .light:
                return UIColor(hex: 0x474747)
            }
        }

        public static var secondary: UIColor { secondary(forTheme: currentTheme) }
        public static func secondary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0xC2C1C6)
            case .light:
                return UIColor(hex: 0x969A9B)
            }
        }
    }

    // MARK: - Button

    public enum Button {

        public static var buttonPrimary: UIColor { buttonPrimary(forTheme: currentTheme) }
        public static func buttonPrimary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x6C78E6)
            case .light:
                return UIColor(hex: 0x515FE1)
            }
        }

        public static var buttonSecondary: UIColor { buttonSecondary(forTheme: currentTheme) }
        public static func buttonSecondary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0xFFFFFF)
            case .light:
                return UIColor(hex: 0x515FE1)
            }
        }

        public static var buttonText: UIColor { buttonText(forTheme: currentTheme) }
        public static func buttonText(forTheme theme: Theme) -> UIColor {
            return UIColor(hex: 0xFFFFFF)
        }
    }

    // MARK: - Shadow

    public enum Shadow {

        public static var dropShadow1: UIColor { dropShadow1(forTheme: currentTheme) }
        public static func dropShadow1(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .light:
                return UIColor(hex: 0x265712).withAlphaComponent(0.07)
            case .dark:
                return UIColor(hex: 0x000033).withAlphaComponent(0.2)
            }
        }
    }

    // MARK: - Gradient

    public enum Gradient {

        public static var skeleton: SkeletonGradient { skeleton(forTheme: currentTheme) }
        public static func skeleton(forTheme theme: Theme) -> SkeletonGradient {
            .init(colors: [UIColor(hex: 0x706D76), UIColor(hex: 0x403A47)])
        }

        public static var gradient1: GradientProps { gradient1(forTheme: currentTheme) }
        public static func gradient1(forTheme theme: Theme) -> GradientProps {
            return .init(
                colors: [
                    UIColor(hex: 0x5884EA),
                    UIColor(hex: 0xBD84FC)
                ],
                direction: .horizontal
            )
        }
    }
}
