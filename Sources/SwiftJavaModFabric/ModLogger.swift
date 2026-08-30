import MinecraftJavaAPI
import SwiftJava

enum ModLogger {
    static func debug(_ message: String) {
        logger.debug(message)
    }

    static func info(_ message: String) {
        logger.info(message)
    }

    static func warn(_ message: String) {
        logger.warn(message)
    }

    static func error(_ message: String) {
        logger.error(message)
    }

    private static var logger: Logger {
        let loggerFactoryClass = try! JavaClass<LoggerFactory>()
        return loggerFactoryClass.getLogger(modID)
    }
}