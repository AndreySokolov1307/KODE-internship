import os

public enum LogEventLevel: String {
    case memory
    case debug
    case info
    case warn
    case error
    case important
    case none

    public var level: Int {
        switch self {
        case .debug, .memory:
            return 0
        case .info:
            return 1
        case .warn:
            return 2
        case .error:
            return 3
        case .important:
            return 4
        case .none:
            return 7
        }
    }

    public var osLogType: OSLogType {
        switch self {
        case .debug, .memory:
            return .debug
        case .info:
            return .info
        case .warn:
            return .error
        case .error:
            return .fault
        case .important:
            return .info
        case .none:
            return .debug
        }
    }

    public var prefixEmoji: String {
        switch self {
        case .memory:
            return ""
        case .debug:
            return "🔵"
        case .info:
            return "🟢"
        case .warn:
            return "🟡"
        case .error:
            return "🔴"
        case .important:
            return "🟣"
        case .none:
            return ""
        }
    }

    public var name: String { rawValue.uppercased() }
}
