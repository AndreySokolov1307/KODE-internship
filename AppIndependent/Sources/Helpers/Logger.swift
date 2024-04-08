import Combine
import os

public final class Logger {

    public var moduleName: String?
    public var minLogLevel: LogEventLevel
    /// If `false` – don't print messages to the console, but pass events via `eventsPublisher`
    public var printMessages: Bool
    public let eventsSubject = CurrentValueSubject<LogEvent?, Never>(nil)
    private static let osLogger = os.Logger(subsystem: subsystem, category: "app")
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    public init(
        moduleName: String? = Bundle.main.bundleIdentifier,
        minLogLevel: LogEventLevel = .info,
        printMessages: Bool = false
    ) {
        self.moduleName = moduleName
        self.minLogLevel = minLogLevel
        self.printMessages = printMessages
    }

    static private func makeDefaultShared() -> Logger {
        Logger(moduleName: nil, minLogLevel: .debug, printMessages: false)
    }

    // MARK: - Public Methods

    public func log(_ messages: String..., eventLevel: LogEventLevel = .debug) {
        log(
            event: LogEvent(
                level: eventLevel,
                moduleName: moduleName,
                messages: messages
            )
        )
    }

    public func debug(_ messages: String...) {
        let concatenatedMessage = messages.joined(separator: " ")
        log(concatenatedMessage, eventLevel: .debug)
    }

    public func info(_ messages: String...) {
        let concatenatedMessage = messages.joined(separator: " ")
        log(concatenatedMessage, eventLevel: .info)
    }

    public func warn(_ messages: String...) {
        let concatenatedMessage = messages.joined(separator: " ")
        log(concatenatedMessage, eventLevel: .warn)
    }

    public func error(_ messages: String...) {
        let concatenatedMessage = messages.joined(separator: " ")
        log(concatenatedMessage, eventLevel: .error)
    }

    public func logDeinit<T>(_ object: T) {
        logDeinit(String(describing: type(of: object)))
    }

    private func logDeinit(_ name: String) {
        debug("Deinit", name)
    }

    // MARK: - Private Methods

    private func log(event: LogEvent) {
        guard
            event.level != .none,
            event.level.level >= minLogLevel.level
        else {
            return
        }
        Self.osLogger.log(level: event.level.osLogType, "\(event.fullLogRecord, privacy: .public)")
        if printMessages {
            print(event.fullLogRecord)
        }
    }
}
