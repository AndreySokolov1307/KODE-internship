// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Main {
  /// Счета
  public static let accounts = Main.tr("Main", "accounts", fallback: "Счета")
  /// Счет расчетный
  public static let currentAccount = Main.tr("Main", "currentAccount", fallback: "Счет расчетный")
  /// Вклады
  public static let deposits = Main.tr("Main", "deposits", fallback: "Вклады")
  /// Главная
  public static let main = Main.tr("Main", "main", fallback: "Главная")
  /// Открыть новый счет или продукт
  public static let openNewAccount = Main.tr("Main", "openNewAccount", fallback: "Открыть новый счет или продукт")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Main {
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
