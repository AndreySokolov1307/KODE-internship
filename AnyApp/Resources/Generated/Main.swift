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
  public enum AccountDetail {
    /// Мобильная связь
    public static let cellular = Main.tr("Main", "accountDetail.cellular", fallback: "Мобильная связь")
    /// Закрыть счет
    public static let closeAccount = Main.tr("Main", "accountDetail.closeAccount", fallback: "Закрыть счет")
    /// Интернет
    public static let internet = Main.tr("Main", "accountDetail.internet", fallback: "Интернет")
    /// ЖКХ
    public static let jkh = Main.tr("Main", "accountDetail.jkh", fallback: "ЖКХ")
    /// Привязанные карты
    public static let linkedCards = Main.tr("Main", "accountDetail.linkedCards", fallback: "Привязанные карты")
    /// -1 500,00
    public static let mockBalance1 = Main.tr("Main", "accountDetail.mockBalance1", fallback: "-1 500,00")
    /// +15 000,00
    public static let mockBalance2 = Main.tr("Main", "accountDetail.mockBalance2", fallback: "+15 000,00")
    /// -6 000,00
    public static let mockBalance3 = Main.tr("Main", "accountDetail.mockBalance3", fallback: "-6 000,00")
    /// Оплата ООО ЯнтарьЭнерго
    public static let mockInfo1 = Main.tr("Main", "accountDetail.mockInfo1", fallback: "Оплата ООО ЯнтарьЭнерго")
    /// Зачисление зарплаты
    public static let mockInfo2 = Main.tr("Main", "accountDetail.mockInfo2", fallback: "Зачисление зарплаты")
    /// Перевод Александру Олеговичу С
    public static let mockInfo3 = Main.tr("Main", "accountDetail.mockInfo3", fallback: "Перевод Александру Олеговичу С")
    /// Переименовать счет
    public static let renameAccount = Main.tr("Main", "accountDetail.renameAccount", fallback: "Переименовать счет")
    /// Реквезиты счета
    public static let requisites = Main.tr("Main", "accountDetail.requisites", fallback: "Реквезиты счета")
  }
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
