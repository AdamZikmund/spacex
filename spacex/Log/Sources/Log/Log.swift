import Foundation

final public class Log {
    // MARK: - Properties
    public static let shared = Log()
    public var level: LogLevel = .debug

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    // MARK: - Lifecycle
    /// Private init to prevent initialization
    private init() {}

    // MARK: - Private
    /// Checks if is logging enabled for given level
    /// - Parameter level: Logging level
    /// - Returns: True if is enabled and false if is not enabled
    private static func isLoggingEnabled(for level: LogLevel) -> Bool {
#if DEBUG
        return level.rawValue >= Self.shared.level.rawValue
#else
        return false
#endif
    }

    // MARK: - Public
    /// Logs debug message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    @discardableResult public static func debug(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) -> String? {
        let level = LogLevel.debug
        guard isLoggingEnabled(for: level) else { return nil }
        var message = ""
        message += Date().format(with: formatter)
        message += " "
        message += "[\(level.symbol)]"
        message += "[\(file.lastPathComponent)]"
        message += "[\(line), \(column)]"
        message += "[\(function)]"
        message += " \(object)"
        print(message)
        return message
    }

    /// Logs info message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    @discardableResult public static func info(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) -> String? {
        let level = LogLevel.info
        guard isLoggingEnabled(for: level) else { return nil }
        var message = ""
        message += Date().format(with: formatter)
        message += " "
        message += "[\(level.symbol)]"
        message += "[\(file.lastPathComponent)]"
        message += "[\(line), \(column)]"
        message += "[\(function)]"
        message += " \(object)"
        print(message)
        return message
    }

    /// Logs verbose message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    @discardableResult public static func verbose(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) -> String? {
        let level = LogLevel.verbose
        guard isLoggingEnabled(for: level) else { return nil }
        var message = ""
        message += Date().format(with: formatter)
        message += " "
        message += "[\(level.symbol)]"
        message += "[\(file.lastPathComponent)]"
        message += "[\(line), \(column)]"
        message += "[\(function)]"
        message += " \(object)"
        print(message)
        return message
    }

    /// Logs warning message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    @discardableResult public static func warning(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) -> String? {
        let level = LogLevel.warning
        guard isLoggingEnabled(for: level) else { return nil }
        var message = ""
        message += Date().format(with: formatter)
        message += " "
        message += "[\(level.symbol)]"
        message += "[\(file.lastPathComponent)]"
        message += "[\(line), \(column)]"
        message += "[\(function)]"
        message += " \(object)"
        print(message)
        return message
    }

    /// Logs severe message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    @discardableResult public static func severe(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) -> String? {
        let level = LogLevel.severe
        guard isLoggingEnabled(for: level) else { return nil }
        var message = ""
        message += Date().format(with: formatter)
        message += " "
        message += "[\(level.symbol)]"
        message += "[\(file.lastPathComponent)]"
        message += "[\(line), \(column)]"
        message += "[\(function)]"
        message += " \(object)"
        print(message)
        return message
    }

    /// Logs error message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    @discardableResult public static func error(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) -> String? {
        let level = LogLevel.error
        guard isLoggingEnabled(for: level) else { return nil }
        var message = ""
        message += Date().format(with: formatter)
        message += " "
        message += "[\(level.symbol)]"
        message += "[\(file.lastPathComponent)]"
        message += "[\(line), \(column)]"
        message += "[\(function)]"
        message += " \(object)"
        print(message)
        return message
    }
}
