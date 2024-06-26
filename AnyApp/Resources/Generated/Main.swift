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
  public enum Account {
    /// Заблокирована
    public static let blocked = Main.tr("Main", "account.blocked", fallback: "Заблокирована")
    /// Цифровая
    public static let digital = Main.tr("Main", "account.digital", fallback: "Цифровая")
    /// Физическая
    public static let physical = Main.tr("Main", "account.physical", fallback: "Физическая")
  }
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
    /// Счет расчетный
    public static let name = Main.tr("Main", "accountDetail.name", fallback: "Счет расчетный")
    /// **** **** **** XXXX
    public static let numberMask = Main.tr("Main", "accountDetail.numberMask", fallback: "**** **** **** XXXX")
    /// Переименовать счет
    public static let renameAccount = Main.tr("Main", "accountDetail.renameAccount", fallback: "Переименовать счет")
    /// Реквезиты счета
    public static let requisites = Main.tr("Main", "accountDetail.requisites", fallback: "Реквезиты счета")
  }
  public enum CardDetail {
    /// Заблокировать карту
    public static let block = Main.tr("Main", "cardDetail.block", fallback: "Заблокировать карту")
    /// Мобильная связь
    public static let cellular = Main.tr("Main", "cardDetail.cellular", fallback: "Мобильная связь")
    /// Информация о карте
    public static let info = Main.tr("Main", "cardDetail.info", fallback: "Информация о карте")
    /// Интернет
    public static let internet = Main.tr("Main", "cardDetail.internet", fallback: "Интернет")
    /// Выпустить карту
    public static let issue = Main.tr("Main", "cardDetail.issue", fallback: "Выпустить карту")
    /// ЖКХ
    public static let jkh = Main.tr("Main", "cardDetail.jkh", fallback: "ЖКХ")
    /// **** XXXX
    public static let numberMask = Main.tr("Main", "cardDetail.numberMask", fallback: "**** XXXX")
    /// Переименовать карту
    public static let rename = Main.tr("Main", "cardDetail.rename", fallback: "Переименовать карту")
    /// Реквезиты счета
    public static let requisites = Main.tr("Main", "cardDetail.requisites", fallback: "Реквезиты счета")
    /// Карты
    public static let title = Main.tr("Main", "cardDetail.title", fallback: "Карты")
  }
  public enum Deposit {
    /// до
    public static let before = Main.tr("Main", "deposit.before", fallback: "до")
    /// Ставка
    public static let interestRate = Main.tr("Main", "deposit.interestRate", fallback: "Ставка")
  }
  public enum Mock {
    /// Дополнительная
    public static let cardName = Main.tr("Main", "mock.cardName", fallback: "Дополнительная")
    /// 8800555353545678
    public static let cardNumber = Main.tr("Main", "mock.cardNumber", fallback: "8800555353545678")
    /// Накопительный
    public static let depositName1 = Main.tr("Main", "mock.depositName1", fallback: "Накопительный")
    /// EUR вклад
    public static let depositName2 = Main.tr("Main", "mock.depositName2", fallback: "EUR вклад")
    /// 1234
    public static let id = Main.tr("Main", "mock.id", fallback: "1234")
    /// Оплата ООО ЯнтарьЭнерго
    public static let transaction1 = Main.tr("Main", "mock.transaction1", fallback: "Оплата ООО ЯнтарьЭнерго")
    /// Зачисление зарплаты
    public static let transaction2 = Main.tr("Main", "mock.transaction2", fallback: "Зачисление зарплаты")
    /// Перевод Александру Олеговичу С test test test test
    public static let transaction3 = Main.tr("Main", "mock.transaction3", fallback: "Перевод Александру Олеговичу С test test test test")
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
