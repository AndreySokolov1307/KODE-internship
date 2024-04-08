public struct LogEvent {
    public let level: LogEventLevel
    public let moduleName: String?
    public let messages: [String]

    public var fullLogRecord: String {
        if let moduleName {
            return "\(level.prefixEmoji) [[\(moduleName)]] [\(level.name)] \(messages.joined(separator: " "))"
        } else {
            return "\(level.prefixEmoji) [\(level.name)] \(messages.joined(separator: " "))"
        }
    }

    public var fullLogRecordForOSLog: String {
        if let moduleName {
            return "[\(moduleName)] \(messages.joined(separator: " "))"
        } else {
            return messages.joined(separator: " ")
        }
    }
}
