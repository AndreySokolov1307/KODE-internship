public enum DateFormat: CaseIterable {
    case fullDate
    case dayMonthYear
    case dayMonthShortYear
    case iso
    case time
    case timeWithSeconds
    case defaultServer
    case dayTime
    case monthYearShort
    case monthYearLong

    public var dateFormat: String {
        switch self {
        case .fullDate:
            return "dd MMMM yyyy HH:mm"
        case .dayMonthYear:
            return "dd.MM.yyyy"
        case .dayMonthShortYear:
            return "dd.MM.yy"
        case .iso:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .time:
            return "HH:mm"
        case .timeWithSeconds:
            return "HH:mm:ss"
        case .defaultServer:
            return "dd.MM.yyyy"
        case .dayTime:
            return "dd MMMM, HH:mm"
        case .monthYearShort:
            return "MM/yy"
        case .monthYearLong:
            return "LLLL yyyy"
        }
    }

    static func from(string: String) -> DateFormat? {
        return Self.allCases.first(where: { $0.dateFormat == string })
    }
}

public extension DateFormatter {

    var format: DateFormat? {
        get {
            DateFormat.from(string: dateFormat ?? "")
        }
        set {
            dateFormat = newValue?.dateFormat
        }
    }
}
