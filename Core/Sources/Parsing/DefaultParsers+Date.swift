import Foundation
import AppIndependent

public extension DefaultParsers {

    enum Date {

        public static func date(from string: String?, format: DateFormat) -> Foundation.Date? {
            guard let string = string?.trimmed else {
                return nil
            }
            let formatter = DateFormatterFactory.formatter(forFormat: format)
            let date = formatter.date(from: string)
            return date
        }

        public static func string(fromOptional date: Foundation.Date?, format: DateFormat) -> String? {
            guard let date = date else {
                return nil
            }
            return string(from: date, format: format)
        }

        public static func string(from date: Foundation.Date, format: DateFormat) -> String {
            let formatter = DateFormatterFactory.formatter(forFormat: format)
            let string = formatter.string(from: date)
            return string
        }

        public static func convertDate(fromString: String?, fromFormat: DateFormat, toFormat: DateFormat) -> String? {
            let date = date(from: fromString, format: fromFormat)
            let toString = string(fromOptional: date, format: toFormat)
            return toString
        }
    }
}

private enum DateFormatterFactory {

    static let fullDateDateFormatter = DateFormatter().also {
        $0.format = .fullDate
    }
    static let dayMonthYearDateFormatter = DateFormatter().also {
        $0.format = .dayMonthYear
    }
    static let dayMonthShortYearDateFormatter = DateFormatter().also {
        $0.format = .dayMonthShortYear
    }
    static let isoDateFormatter = DateFormatter().also {
        $0.format = .iso
    }
    static let defaultServerDateFormatter = DateFormatter().also {
        $0.format = .defaultServer
    }
    static let defaultTimeFormatter = DateFormatter().also {
        $0.format = .time
    }
    static let defaultTimeWithSecondsFormatter = DateFormatter().also {
        $0.format = .timeWithSeconds
    }

    static func formatter(forFormat format: DateFormat) -> DateFormatter {
        switch format {
        case .fullDate:
            return fullDateDateFormatter
        case .dayMonthYear:
            return dayMonthYearDateFormatter
        case .dayMonthShortYear:
            return dayMonthShortYearDateFormatter
        case .iso:
            return isoDateFormatter
        case .defaultServer:
            return defaultServerDateFormatter
        case .time:
            return defaultTimeFormatter
        case .timeWithSeconds:
            return defaultTimeWithSecondsFormatter
        }
    }
}
