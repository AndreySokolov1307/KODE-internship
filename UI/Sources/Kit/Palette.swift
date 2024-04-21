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
        
        public static var backgroundSecondary: UIColor { backgroundSecondary(forTheme: currentTheme) }
        public static func backgroundSecondary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x353F3D)
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
        
        public static var secondary: UIColor { secondary(forTheme: currentTheme) }
        public static func secondary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x403A47)
            case .light:
                return UIColor(hex: 0xF3F3F3)
            }
        }
        
        public static var tertiary: UIColor { tertiary(forTheme: currentTheme) }
        public static func tertiary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x706D76)
            case .light:
                return UIColor(hex: 0xF3F3F3)
            }
        }
        
        public static var accentPrimary: UIColor { accentPrimary(forTheme: currentTheme) }
        public static func accentPrimary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x6C78E6)
            case .light:
                return UIColor(hex: 0x515FE1)
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
        
        public static var accentTertirary: UIColor { accentTertiary(forTheme: currentTheme) }
        public static func accentTertiary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0xFFFFFF)
            case .light:
                return UIColor(hex: 0x474747)
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
        
        public static var tertiary: UIColor { tertiary(forTheme: currentTheme) }
        public static func tertiary(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x706D76)
            case .light:
                return UIColor(hex: 0xC8CBD0)
            }
        }
    }
    
    // MARK: - Indicator
    
    public enum Indicator {
        
        public static var contentError: UIColor { contentError(forTheme: currentTheme) }
        public static func contentError(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0xFB6176)
            case .light:
                return UIColor(hex: 0xFE626A)
            }
        }
        
        public static var contentDone: UIColor { contentDone(forTheme: currentTheme) }
        public static func contentDone(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x4CD563)
            case .light:
                return UIColor(hex: 0x39D052)
            }
        }
        
        public static var contentSuccess: UIColor { contentSuccess(forTheme: currentTheme) }
        public static func contentSuccess(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .dark:
                return UIColor(hex: 0x6C78E6)
            case .light:
                return UIColor(hex: 0x515FE1)
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
        
        public static var card: UIColor { card(forTheme: currentTheme) }
        public static func card(forTheme theme: Theme) -> UIColor {
            switch theme {
            case .light:
                return UIColor(hex: 0x002657).withAlphaComponent(0.11)
            case .dark:
                return UIColor(hex: 0x000033).withAlphaComponent(0.4)
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
