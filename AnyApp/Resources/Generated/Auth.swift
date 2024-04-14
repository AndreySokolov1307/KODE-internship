// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Entrance {
  /// Войти
  public static let enter = Entrance.tr("Auth", "enter", fallback: "Войти")
  /// Телефон
  public static let loginPlaceholder = Entrance.tr("Auth", "loginPlaceholder", fallback: "Телефон")
  /// На ваш номер отправлено SMS с кодом подтверждения
  public static let otpLabel = Entrance.tr("Auth", "otpLabel", fallback: "На ваш номер отправлено SMS с кодом подтверждения")
  /// +# (###) ### ## ##
  public static let phonePattern = Entrance.tr("Auth", "phonePattern", fallback: "+# (###) ### ## ##")
  /// Повторить через 
  public static let repeatAfter = Entrance.tr("Auth", "repeatAfter", fallback: "Повторить через ")
  /// #
  public static let replacementCharacter = Entrance.tr("Auth", "replacementCharacter", fallback: "#")
  /// Выслать код повторно
  public static let sendOTPAgain = Entrance.tr("Auth", "sendOTPAgain", fallback: "Выслать код повторно")
  public enum Error {
    /// Данная сессия авторизации будет сброшена
    public static let worngInputMessage = Entrance.tr("Auth", "error.worngInputMessage", fallback: "Данная сессия авторизации будет сброшена")
    /// Вы ввели неверно код 5 раз
    public static let wrongInputTitle = Entrance.tr("Auth", "error.wrongInputTitle", fallback: "Вы ввели неверно код 5 раз")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Entrance {
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
