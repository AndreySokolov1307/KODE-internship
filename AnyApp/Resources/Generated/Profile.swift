// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Profile {
  /// О приложении
  public static let about = Profile.tr("Profile", "about", fallback: "О приложении")
  /// Выход
  public static let logOut = Profile.tr("Profile", "logOut", fallback: "Выход")
  /// Профиль
  public static let profile = Profile.tr("Profile", "profile", fallback: "Профиль")
  /// Служба поддержки
  public static let support = Profile.tr("Profile", "support", fallback: "Служба поддержки")
  /// Тема приложения
  public static let theme = Profile.tr("Profile", "theme", fallback: "Тема приложения")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Profile {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
